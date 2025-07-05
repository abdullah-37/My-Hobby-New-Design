import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/discussion/discussions_detail_controller.dart';
import 'package:hobby_club_app/models/club/discussion/discussions_detail_model.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class DiscussionDetailScreen extends StatefulWidget {
  final String clubId;
  final String discussionId;

  const DiscussionDetailScreen({
    super.key,
    required this.clubId,
    required this.discussionId,
  });

  @override
  State<DiscussionDetailScreen> createState() => _DiscussionDetailScreenState();
}

class _DiscussionDetailScreenState extends State<DiscussionDetailScreen> {
  final controller = Get.put(DiscussionsDetailController());

  @override
  void initState() {
    controller.fetchDiscussionDetails(
      clubId: widget.clubId,
      discussionsId: widget.discussionId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Discussions', isLeading: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerDiscussionHeader(),
                  SizedBox(height: 24),
                  ShimmerRepliesTitle(),
                  SizedBox(height: 16),
                  ShimmerRepliesList(),
                ],
              ),
            ),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.red),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDiscussionHeader(controller),
                    const SizedBox(height: 24),
                    Text(
                      'Replies (${controller.replies.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    controller.replies.isEmpty
                        ? _buildEmptyReplies(context)
                        : _buildRepliesList(controller),
                  ],
                ),
              ),
            ),
            _buildReplyInput(controller),
          ],
        );
      }),
    );
  }

  Widget _buildDiscussionHeader(DiscussionsDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  controller.discussionDetail.value?.profile.img ??
                      'https://via.placeholder.com/48',
                ),
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.discussionDetail.value?.profile.userName ??
                          'Unknown User',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      controller.formatDate(
                        controller.discussionDetail.value?.createdAt
                                .toIso8601String() ??
                            '',
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            controller.discussionDetail.value?.title ?? 'No Title',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          if (controller.discussionDetail.value?.image != null &&
              controller.discussionDetail.value!.image.isNotEmpty)
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(controller.discussionDetail.value!.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Text(
            controller.discussionDetail.value?.desc ??
                'No description available',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyReplies(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No replies yet',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to reply to this discussion',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepliesList(DiscussionsDetailController controller) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.replies.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final reply = controller.replies[index];
          return _buildReplyItem(reply, controller);
        },
      ),
    );
  }

  Widget _buildReplyItem(
    DiscussionReply reply,
    DiscussionsDetailController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: .2, color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(reply.image),
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      reply.userName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.formatDate(reply.createdAt.toIso8601String()),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  reply.reply,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyInput(DiscussionsDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.replyController,
                decoration: InputDecoration(
                  hintText: 'Write your reply...',
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: Theme.of(context).inputDecorationTheme.filled,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
                onSubmitted: (_) {
                  if (controller.replyController.text.trim().isNotEmpty) {
                    controller.addReply(
                      clubId: widget.clubId,
                      discussionId: widget.discussionId,
                      replyText: controller.replyController.text.trim(),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () =>
                  controller.isReplyLoading.value
                      ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (controller.replyController.text
                                .trim()
                                .isNotEmpty) {
                              controller.addReply(
                                clubId: widget.clubId,
                                discussionId: widget.discussionId,
                                replyText:
                                    controller.replyController.text.trim(),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerDiscussionHeader extends StatelessWidget {
  const ShimmerDiscussionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return shimmerContainer(
      height: 220,
      borderRadius: BorderRadius.circular(12),
    );
  }
}

class ShimmerRepliesTitle extends StatelessWidget {
  const ShimmerRepliesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return shimmerBox(width: 120, height: 20);
  }
}

class ShimmerRepliesList extends StatelessWidget {
  const ShimmerRepliesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => const ShimmerReplyItem()),
    );
  }
}

class ShimmerReplyItem extends StatelessWidget {
  const ShimmerReplyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: .2, color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          shimmerContainer(width: 40, height: 40, shape: BoxShape.circle),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(width: 100, height: 12),
                const SizedBox(height: 6),
                shimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 4),
                shimmerBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

Widget shimmerContainer({
  double width = double.infinity,
  double height = 100,
  BorderRadius? borderRadius,
  BoxShape shape = BoxShape.rectangle,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
      ),
    ),
  );
}
