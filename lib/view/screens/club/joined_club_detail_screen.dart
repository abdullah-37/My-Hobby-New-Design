import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/theme_controller.dart';
import 'package:hobby_club_app/models/club/club_feed_model.dart';
import 'package:hobby_club_app/view/widgets/cretae_post_widget.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

// Your existing model classes would go here
// ClubFeedModel, Data, Comment, CommentProfile, DataProfile

class JoinedClubDetailScreen extends StatefulWidget {
  const JoinedClubDetailScreen({super.key});

  @override
  State<JoinedClubDetailScreen> createState() => _ClubFeedsScreenState();
}

class _ClubFeedsScreenState extends State<JoinedClubDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();

  // Sample data for demonstration
  List<Data> feedData = [
    Data(
      id: 1,
      likes: 24,
      isLike: false,
      image: "https://picsum.photos/400/300?random=1",
      desc:
          "Just finished an amazing workout session! Feeling energized and ready to take on the world. 💪 #FitnessMotivation #ClubLife",
      updatedAt: "2024-06-20T10:30:00Z",
      profile: DataProfile(
        userName: "fitness_guru",
        firstName: "Sarah",
        lastName: "Johnson",
        img: "https://picsum.photos/150/150?random=person1",
      ),
      comments: [
        Comment(
          id: 1,
          comment: "Inspiring! Keep it up! 🔥",
          userId: 2,
          updatedAt: "2024-06-20T11:00:00Z",
          profile: CommentProfile(
            userName: "mike_runner",
            img: "https://picsum.photos/150/150?random=person2",
          ),
        ),
        Comment(
          id: 2,
          comment: "Great motivation for my evening workout!",
          userId: 3,
          updatedAt: "2024-06-20T11:15:00Z",
          profile: CommentProfile(
            userName: "anna_yoga",
            img: "https://picsum.photos/150/150?random=person3",
          ),
        ),
      ],
    ),
    Data(
      id: 2,
      likes: 156,
      isLike: true,
      image: "https://picsum.photos/400/300?random=2",
      desc:
          "Beautiful sunset from today's hiking adventure! Nature never fails to amaze me. 🌅 Who wants to join next time?",
      updatedAt: "2024-06-20T08:45:00Z",
      profile: DataProfile(
        userName: "adventure_seeker",
        firstName: "David",
        lastName: "Chen",
        img: "https://picsum.photos/150/150?random=person4",
      ),
      comments: [
        Comment(
          id: 3,
          comment: "Count me in for the next adventure!",
          userId: 4,
          updatedAt: "2024-06-20T09:00:00Z",
          profile: CommentProfile(
            userName: "trail_blazer",
            img: "https://picsum.photos/150/150?random=person5",
          ),
        ),
      ],
    ),
    Data(
      id: 3,
      likes: 89,
      isLike: false,
      image: null,
      desc:
          "Just read an incredible book about personal development. 'The only way to do great work is to love what you do.' - Steve Jobs. What's everyone reading lately? 📚✨",
      updatedAt: "2024-06-19T20:30:00Z",
      profile: DataProfile(
        userName: "book_lover",
        firstName: "Emma",
        lastName: "Williams",
        img: "https://picsum.photos/150/150?random=person6",
      ),
      comments: [
        Comment(
          id: 4,
          comment: "Love that quote! Currently reading 'Atomic Habits'",
          userId: 5,
          updatedAt: "2024-06-19T21:00:00Z",
          profile: CommentProfile(
            userName: "habit_builder",
            img: "https://picsum.photos/150/150?random=person7",
          ),
        ),
        Comment(
          id: 5,
          comment: "Thanks for the recommendation!",
          userId: 6,
          updatedAt: "2024-06-19T21:30:00Z",
          profile: CommentProfile(
            userName: "reader_pro",
            img: "https://picsum.photos/150/150?random=person8",
          ),
        ),
      ],
    ),
  ];

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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTimeAgo(String dateTime) {
    final now = DateTime.now();
    final date = DateTime.parse(dateTime);
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _toggleLike(int index) {
    setState(() {
      feedData[index].isLike = !feedData[index].isLike;
      if (feedData[index].isLike) {
        feedData[index].likes++;
      } else {
        feedData[index].likes--;
      }
    });
    HapticFeedback.lightImpact();
  }

  void _showCommentsBottomSheet(Data data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.white,
      builder: (context) => _buildCommentsBottomSheet(data),
    );
  }

  Widget _buildCommentsBottomSheet(Data data) {
    ThemeController themeController = Get.find<ThemeController>();
    return Obx(
      () => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color:
              themeController.themeMode.value == ThemeMode.dark
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    themeController.themeMode.value == ThemeMode.dark
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.comment_outlined, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text(
                    'Comments (${data.comments.length})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.comments.length,
                itemBuilder: (context, index) {
                  final comment = data.comments[index];
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
                              ).primaryColor.withValues(alpha: 0.1),
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
                                  _formatTimeAgo(comment.updatedAt),
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
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    themeController.themeMode.value == ThemeMode.dark
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color:
                        themeController.themeMode.value == ThemeMode.dark
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      "https://picsum.photos/150/150?random=currentuser",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Add a comment...'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.purple],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => CreatePostDialog(
                    onPostCreated: (description, imagePath) {
                      // Handle the created post
                      print('Post created: $description');
                      if (imagePath != null) {
                        print('Image: $imagePath');
                      }
                      // Add the post to your feed data
                      // Refresh your feed UI
                    },
                  ),
            );
          },

          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      // backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: 'Club Name'),
      //   centerTitle: false,
      //   actions: [
      //     Container(
      //       margin: const EdgeInsets.only(right: 16),
      //       decoration: BoxDecoration(
      //         gradient: const LinearGradient(
      //           colors: [Colors.deepPurple, Colors.purple],
      //         ),
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: IconButton(s
      //         onPressed: () {},
      //         icon: const Icon(Icons.add, color: Colors.white),
      //       ),
      //     ),
      //   ],
      // ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: feedData.length,
            itemBuilder: (context, index) {
              return _buildFeedCard(feedData[index], index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeedCard(Data data, int index) {
    ThemeController themeController = Get.find<ThemeController>();
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              themeController.themeMode.value == ThemeMode.dark
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                  : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  themeController.themeMode.value == ThemeMode.dark
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
              // Header
              Padding(
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
                        backgroundImage: NetworkImage(data.profile.img),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.profile.firstName} ${data.profile.lastName}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '@${data.profile.userName}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _formatTimeAgo(data.updatedAt),
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  data.desc,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              // Image (if exists)
              if (data.image != null) ...[
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(data.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],

              // Actions
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                      icon:
                          data.isLike ? Icons.favorite : Icons.favorite_border,
                      label: '${data.likes}',
                      color: data.isLike ? Colors.red : Colors.grey[600]!,
                      onTap: () => _toggleLike(index),
                    ),
                    _buildActionButton(
                      icon: Icons.comment_outlined,
                      label: '${data.comments.length}',
                      color: Colors.grey[600]!,
                      onTap: () => _showCommentsBottomSheet(data),
                    ),
                    _buildActionButton(
                      icon: Icons.share_outlined,
                      label: 'Share',
                      color: Colors.grey[600]!,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Post shared!'),
                            backgroundColor: Colors.deepPurple,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.bookmark_border,
                      label: 'Save',
                      color: Colors.grey[600]!,
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
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
            Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
