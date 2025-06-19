import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';

class CustomClubCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String desc;
  final String subtitle;
  final String status;
  final int eventsCount;
  final String membersCount;
  final VoidCallback? onTap;

  const CustomClubCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.desc,
    required this.subtitle,
    required this.status,
    required this.eventsCount,
    required this.membersCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white.withValues(alpha: 0.1),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        ),
        margin: EdgeInsets.symmetric(
          // vertical: Dimensions.height10,
          // horizontal: Dimensions.width10,
        ),
        child: Padding(
          padding: Dimensions.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  // CustomNetworkImage(
                  //   size: Dimensions.width60,
                  //   imageUrl: imageUrl ?? '',
                  // ),
                  // SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyles.cardTitle.copyWith(
                            fontSize: Dimensions.font18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          desc,
                          style: AppStyles.body.copyWith(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        _InfoItem(
                          icon: Icons.event,
                          label: '$eventsCount Events',
                        ),
                        SizedBox(height: 5),

                        _InfoItem(
                          icon: Icons.group,
                          label: '$membersCount Members',
                        ),
                      ],
                    ),
                  ),
                  // Chip(
                  //   label: Text(
                  //     status,
                  //     style: AppStyles.body.copyWith(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   backgroundColor: _statusColor(status),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(
                          Dimensions.cardRadius,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl!,
                        placeholder: (context, url) => Icon(Icons.error),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
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
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: Dimensions.icon16, color: AppColors.primary),
        SizedBox(width: 4),
        Text(
          label,
          style: AppStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
