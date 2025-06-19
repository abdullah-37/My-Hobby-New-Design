import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool isLeading;

  const CustomAppBar({super.key, required this.title, this.centerTitle = true, this.isLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(title, style: AppStyles.largeHeading),
      leading: isLeading ?GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
      ):SizedBox.shrink(),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
