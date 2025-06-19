import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';

class CustomEventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomEventCard({
    super.key,
    required this.icon,
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
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimensions.cardRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: Dimensions.icon28, color: AppColors.primary),
                SizedBox(width: Dimensions.width20),
                Text(title, style: AppStyles.cardTitle),
              ],
            ),
            SizedBox(height: Dimensions.height5),
            Text(subtitle, style: AppStyles.cardSubTitle),
          ],
        ),
      ),
    );
  }
}
