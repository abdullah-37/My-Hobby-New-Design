import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';

import 'custom_network_image.dart';

class RecommendedClubCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const RecommendedClubCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Dimensions.cardPadding,
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        ),
        child: Row(
          children: [
            ClipOval(
              child: CustomNetworkImage(
                size: Dimensions.width60,
                imageUrl: imageUrl ?? "",
              ),
            ),
            SizedBox(width: Dimensions.width20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyles.cardTitle),
                  SizedBox(height: Dimensions.height5),
                  Text(
                    subtitle,
                    style: AppStyles.cardSubTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: Dimensions.icon20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
