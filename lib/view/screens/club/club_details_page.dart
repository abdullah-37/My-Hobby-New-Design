import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/join_club_controller.dart';
import 'package:hobby_club_app/controller/theme/theme_controller.dart';
import 'package:hobby_club_app/models/club/trending_club_model.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:shimmer/shimmer.dart';

class ClubDetailsPage extends StatefulWidget {
  final TrendingClub club;

  const ClubDetailsPage({super.key, required this.club});

  @override
  State<ClubDetailsPage> createState() => _ClubDetailsPageState();
}

class _ClubDetailsPageState extends State<ClubDetailsPage> {
  final JoinClubController joinClubController = Get.put(JoinClubController());
  final TextEditingController _referralCodeController = TextEditingController();
  bool _isLoading = false;

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

  void _showJoinClubDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.group_add,
                  color: Theme.of(context).iconTheme.color,
                  size: 40,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Join',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                widget.club.title,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'You\'re about to join this amazing club!\nDo you have a referral code?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                  height: 1.4,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _referralCodeController,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    letterSpacing: 2,
                    color: Colors.black
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter referral code (optional)',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.card_giftcard,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Referral code is optional',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed:
                      _isLoading
                          ? null
                          : () {
                        _referralCodeController.clear();
                        Get.close(1);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        joinClubController.joinClub(clubId: widget.club.id.toString(),referralCode: _referralCodeController.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Text(
                        'Join Club',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
                ? _buildEventShimmer()
                :SizedBox(
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
                ? _buildFeedShimmer()
                :ListView.builder(
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
                              ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              themeController.themeMode.value == ThemeMode.dark
                                  ? Colors.transparent
                                  : Colors.grey.withValues(alpha: 0.2),
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feedData.postedBy.fullName,
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                          Text(
                                            '@${feedData.postedBy.userName}',
                                            style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey[200],
                                          image:
                                          feedData.badge.img.isNotEmpty
                                              ? DecorationImage(
                                            image: NetworkImage(feedData.badge.img),
                                            fit: BoxFit.cover,
                                            onError: (exception, stackTrace) {
                                              debugPrint('Failed to load image: $exception');
                                            },
                                          )
                                              : null,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: club.profile.fullName.isEmpty
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
              child: CustomElevatedButton(onTap: _showJoinClubDialog, title: 'Join Club'),
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
          Text(title, maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge),
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

  Widget _buildEventShimmer() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 3,
        itemBuilder:
            (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(width: 100, height: 16, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(width: 140, height: 12, color: Colors.white),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildFeedShimmer() {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
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
