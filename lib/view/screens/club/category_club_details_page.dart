import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/join_club_controller.dart';
import 'package:hobby_club_app/controller/raw/theme_controller.dart';
import 'package:hobby_club_app/models/category_club_model.dart';
import 'package:hobby_club_app/models/trending_club_model.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

class CategoryClubDetailsPage extends StatefulWidget {
  final CategoryClub club;

  CategoryClubDetailsPage({super.key, required this.club});

  @override
  State<CategoryClubDetailsPage> createState() =>
      _CategoryClubDetailsPageState();
}

class _CategoryClubDetailsPageState extends State<CategoryClubDetailsPage> {
  final joinClubController = Get.put(JoinClubController());
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

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final club = widget.club;
    return Scaffold(
      appBar: CustomAppBar(title: 'CLub Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 218,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(club.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                club.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                textAlign: TextAlign.center,
                club.desc,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.group,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${club.totalMembers} members',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            club.schedules.isEmpty
                ? Text(
                  'No Event is available on that club!',
                  style: Theme.of(context).textTheme.bodySmall,
                )
                : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: club.schedules.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final schedule = club.schedules[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _eventCard(
                          context: context,
                          title: schedule.title,
                          subtitle: schedule.description,
                          imageUrl: schedule.img,
                        ),
                      );
                    },
                  ),
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Recent Activities',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            club.feeds.isEmpty
                ? Text(
                  'No Feeds is available on that club!',
                  style: Theme.of(context).textTheme.bodySmall,
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: club.feeds.length,
                  itemBuilder: (context, index) {
                    final feedData = club.feeds[index];
                    return Obx(
                      () => Container(
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
                                        backgroundImage: NetworkImage(
                                          feedData.postedBy.img,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feedData.postedBy.fullName,
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyLarge,
                                          ),
                                          Text(
                                            '@${feedData.postedBy.userName}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  feedData.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ).copyWith(top: 12),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(feedData.img),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _actionButton(
                                      icon: Icons.favorite_border,
                                      label: feedData.likeCount.toString(),
                                      onTap: () {},
                                    ),
                                    _actionButton(
                                      icon: Icons.comment_outlined,
                                      label: feedData.commentCount.toString(),
                                      onTap: () {},
                                    ),
                                    _actionButton(
                                      icon: Icons.remove_red_eye_outlined,
                                      label: feedData.commentCount.toString(),
                                      onTap: () {},
                                    ),
                                    Text(
                                      _formatTimeAgo(
                                        feedData.updatedAt.toIso8601String(),
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Admins',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  club.profile.fullName.isEmpty
                      ? _buildAdminShimmer()
                      : _adminCard(
                        context: context,
                        imageUrl: club.profile.img,
                        name: club.profile.fullName,
                        role: '@${club.profile.userName}',
                      ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: Dimensions.screenPaddingHorizontal,
              child: CustomElevatedButton(onTap: () {
                joinClubController.joinClub(clubId: club.id.toString());
              }, title: 'Join Club'),
            ),
            SizedBox(height: 20),
          ],
        ),
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

  Widget _eventCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _adminCard({
    required String imageUrl,
    required String name,
    required String role,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.bodyLarge),
            Text(
              role,
              style: const TextStyle(fontSize: 14, color: Color(0xFF60768a)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdminShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 100, height: 16, color: Colors.white),
                const SizedBox(height: 8),
                Container(width: 60, height: 12, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
