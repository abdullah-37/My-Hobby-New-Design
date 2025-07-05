import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/discussion/club_discussions_controller.dart';
import 'package:hobby_club_app/view/discussion%20view/create_discussion_screen.dart';
import 'package:hobby_club_app/view/discussion%20view/disussion_detail_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class DiscussionScreen extends StatefulWidget {
  final String clubId;

  const DiscussionScreen({super.key, required this.clubId});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final clubDiscussionsController = Get.put(ClubDiscussionsController());

  @override
  void initState() {
    clubDiscussionsController.clubDiscussion(clubId: widget.clubId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Discussions', isLeading: true),
      body: Stack(
        children: [
          Obx(() {
            if (clubDiscussionsController.isLoading.value) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 5,
                itemBuilder: (context, index) => const ShimmerDiscussionCard(),
              );
            } else if (clubDiscussionsController.discussions.isEmpty) {
              return const Center(
                child: Text(
                  'No Discussions available',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: clubDiscussionsController.discussions.length,
                itemBuilder: (context, index) {
                  final discussion = clubDiscussionsController.discussions[index];
                  final formattedTime = discussion.latestReply != null
                      ? clubDiscussionsController.timeAgoSince(discussion.latestReply!)
                      : 'No replies yet';
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                            () => DiscussionDetailScreen(
                          clubId: widget.clubId,
                          discussionId: discussion.id.toString(),
                        ),
                        arguments: {
                          "clubId": int.parse(widget.clubId),
                          "discussionId": discussion.id,
                        },
                      )?.then((result) {
                        if (result == true) {
                          clubDiscussionsController.getClubDiscussions(
                            clubDiscussionsController.id,
                          );
                        }
                      });
                    },
                    child: ModernDiscussionWidget(
                      channelName: discussion.tag,
                      title: discussion.title,
                      lastReply: formattedTime,
                      noReply: discussion.repliesCount.toString(),
                      imageUrl: discussion.image,
                    ),
                  );
                },
              );
            }
          }),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => CreateDiscussionScreen(clubId: widget.clubId));
              },
              backgroundColor: const Color(0xFFDCE8F3),
              elevation: 0,
              child: const Icon(Icons.add, color: Color(0xFF121416), size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class ModernDiscussionWidget extends StatelessWidget {
  final String channelName;
  final String title;
  final String lastReply;
  final String noReply;
  final String? imageUrl;

  const ModernDiscussionWidget({
    super.key,
    required this.channelName,
    required this.title,
    required this.lastReply,
    required this.noReply,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channelName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  noReply == '0' ? 'No reply yet' : 'Latest reply: $lastReply',
                  style: const TextStyle(
                    color: Color(0xFF6A7681),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child:
                    imageUrl != null && imageUrl!.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholderImage();
                            },
                          ),
                        )
                        : _buildPlaceholderImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[100]!, Colors.purple[100]!],
        ),
      ),
      child: const Center(
        child: Icon(Icons.image, color: Colors.grey, size: 32),
      ),
    );
  }
}

class ShimmerDiscussionCard extends StatelessWidget {
  const ShimmerDiscussionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side shimmer
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(width: 100, height: 16),
                const SizedBox(height: 8),
                shimmerBox(width: double.infinity, height: 20),
                const SizedBox(height: 8),
                shimmerBox(width: 150, height: 14),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right side shimmer
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: shimmerBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerBox({double width = double.infinity, double height = 100}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
