import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club_feed_controller.dart';
import 'package:hobby_club_app/controller/raw/theme_controller.dart';
import 'package:hobby_club_app/models/club_feed_model.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';
import 'package:hobby_club_app/view/discussion%20view/discussion_screen.dart';
import 'package:hobby_club_app/view/gamification/gamification_page.dart';
import 'package:hobby_club_app/view/screens/club/club_feed_shimmer.dart';
import 'package:hobby_club_app/view/screens/events/club_event_screen.dart';
import 'package:hobby_club_app/view/widgets/cretae_post_widget.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/expandable_floating_button.dart';

class JoinedClubDetailScreen extends StatefulWidget {
  final String clubId;
  final String clubImage;
  final String clubName;
  final String clubDesc;

  const JoinedClubDetailScreen({
    super.key,
    required this.clubId,
    required this.clubImage,
    required this.clubName,
    required this.clubDesc,
  });

  @override
  State<JoinedClubDetailScreen> createState() => _JoinedClubDetailScreenState();
}

class _JoinedClubDetailScreenState extends State<JoinedClubDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();
  final ClubFeedController _feedController = Get.put(ClubFeedController());
  bool _isFabVisible = true;
  double _lastScrollOffset = 0;
  late AnimationController _fabVisibilityController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fabVisibilityController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fabVisibilityController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _feedController.clubFeed(clubId: widget.clubId);
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final currentScrollOffset = _scrollController.offset;

    if (currentScrollOffset > _lastScrollOffset && currentScrollOffset > 50) {
      if (_isFabVisible) {
        setState(() => _isFabVisible = false);
        _fabVisibilityController.forward();
      }
    } else if (currentScrollOffset < _lastScrollOffset) {
      if (!_isFabVisible) {
        setState(() => _isFabVisible = true);
        _fabVisibilityController.reverse();
      }
    }

    _lastScrollOffset = currentScrollOffset;
  }

  void _toggleLike(int index) {
    final feed = _feedController.clubFeedModel.value!.data[index];
    _feedController.clubFeedLike(
      clubId: widget.clubId,
      feedId: feed.id.toString(),
      isCurrentlyLiked: feed.isLike,
      currentLikes: feed.likes,
      feedIndex: index,
    );
    HapticFeedback.lightImpact();
  }

  void _showComments(BuildContext context, int index) {
    final feed = _feedController.clubFeedModel.value!.data[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => CommentsBottomSheet(
            comments: feed.comments,
            formatTimeAgo: _formatTimeAgo,
            clubId: widget.clubId,
            feedId: feed.id.toString(),
            feedIndex: index,
          ),
    );
  }

  String _formatTimeAgo(String dateTime) {
    final now = DateTime.now();
    final date = DateTime.parse(dateTime);
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }

  Widget _buildClubDetails() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(widget.clubImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.clubName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.clubDesc,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubEventDetails(final themeController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Club Events',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: (){
              Get.to(()=> ClubEventScreen(clubId: widget.clubId,));
            },
            child: Icon(
              Icons.forward_rounded,
              size: 30,
              color:
              themeController.themeMode.value == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      floatingActionButton: _isFabVisible
          ? Stack(
        children: [
          ExpandableFabMenu(
            onDiscussionTap: () {
              Get.to(() => DiscussionScreen());
            },
            onCreateFeedTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) => CreatePostDialog(
                      clubId: widget.clubId,
                      image: _feedController.profile.img,
                      username: _feedController.profile.userName,
                      fullName: _feedController.profile.firstName,
                      onPostCreated: (description, imagePath) {
                        print('Post created successfully');
                        print('Post text: $description');
                        if (imagePath != null) {
                          print('Image: $imagePath');
                        }
                      },
                    ),
              );
            },
            onMessengerTap: () {
              Get.to(() => ChatScreen());
            },
          ),
        ],
      ) : null,
      appBar: CustomAppBar(title: 'Club', actionIcon: Icons.info_outlined,isAction: true, onAction: () {Get.to(()=> GamificationPage());}),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: () async {
            await _feedController.clubFeed(clubId: widget.clubId);
          },
          color: Theme.of(context).primaryColor,
          child: Obx(() {
            if (_feedController.isLoading.value) {
              return const ClubFeedShimmer();
            }
            if (_feedController.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(
                  _feedController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            final feeds = _feedController.clubFeedModel.value?.data ?? [];
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(child: _buildClubDetails()),
                SliverToBoxAdapter(child: _buildClubEventDetails(themeController)),
                if (feeds.isEmpty)
                  SliverFillRemaining(
                    child: const Center(child: Text('No feeds available')),
                  ),
                if (feeds.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final feed = feeds[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeController.themeMode.value == ThemeMode.dark
                                  ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.2)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  themeController.themeMode.value ==
                                          ThemeMode.dark
                                      ? Colors.transparent
                                      : Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(context, feed),
                              _buildDescription(context, feed),
                              if (feed.image.isNotEmpty) _buildImage(feed),
                              _buildActions(context, feed, index),
                            ],
                          ),
                        ),
                      );
                    }, childCount: feeds.length),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, feed) {
    final profile = feed.profile;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(profile.img),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '@${profile.userName}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, feed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        feed.desc ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildImage(feed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          image:
              feed.image != null && feed.image.isNotEmpty
                  ? DecorationImage(
                    image: NetworkImage(feed.image),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      print('Failed to load image: $exception');
                    },
                  )
                  : null,
        ),
        child:
            feed.image == null || feed.image.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No Image Available',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                )
                : null,
      ),
    );
  }

  Widget _buildActions(BuildContext context, feed, int index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(
            icon: feed.isLike ? Icons.favorite : Icons.favorite_border,
            label: '${feed.likes}',
            onTap: () => _toggleLike(index),
          ),
          _actionButton(
            icon: Icons.comment_outlined,
            label: '${feed.comments.length}',
            onTap: () => _showComments(context, index),
          ),
          _actionButton(
            icon: Icons.remove_red_eye_outlined,
            label: '${feed.comments.length}',
            onTap: () {},
          ),
          Text(
            _formatTimeAgo(feed.updatedAt.toIso8601String()),
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).primaryColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsBottomSheet extends StatefulWidget {
  final List<FeedComment> comments;
  final String Function(String) formatTimeAgo;
  final String clubId;
  final String feedId;
  final int feedIndex;

  const CommentsBottomSheet({
    super.key,
    required this.comments,
    required this.formatTimeAgo,
    required this.clubId,
    required this.feedId,
    required this.feedIndex,
  });

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final ClubFeedController _feedController = Get.find<ClubFeedController>();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _postComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final comment = _commentController.text.trim();
    _commentController.clear();

    final success = await _feedController.clubFeedComment(
      clubId: widget.clubId,
      feedId: widget.feedId,
      comment: comment,
      feedIndex: widget.feedIndex,
    );

    if (!success) {
      // Show error message if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_feedController.errorMessage.value),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.themeMode.value == ThemeMode.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color:
            isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.comment_outlined, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Obx(() {
                  final currentComments =
                      _feedController
                          .clubFeedModel
                          .value
                          ?.data[widget.feedIndex]
                          .comments ??
                      widget.comments;
                  return Text(
                    'Comments (${currentComments.length})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final currentComments =
                  _feedController
                      .clubFeedModel
                      .value
                      ?.data[widget.feedIndex]
                      .comments ??
                  widget.comments;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: NeverScrollableScrollPhysics(),
                itemCount: currentComments.length,
                itemBuilder: (context, index) {
                  final comment = currentComments[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(comment.profile.img),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.profile.userName,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(comment.comment),
                                const SizedBox(height: 4),
                                Text(
                                  widget.formatTimeAgo(
                                    comment.updatedAt.toIso8601String(),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    _feedController.profile.img!,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.purple],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed:
                          _feedController.isCommentLoading.value
                              ? null
                              : _postComment,
                      icon:
                          _feedController.isCommentLoading.value
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
