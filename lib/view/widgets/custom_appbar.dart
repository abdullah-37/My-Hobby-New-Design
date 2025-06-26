import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/raw/theme_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool isLeading;
  final bool isAction;
  final IconData? actionIcon;
  final Function()? onAction;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.isLeading = true,
    this.isAction = false,
    this.actionIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(title, style: Theme.of(context).textTheme.displayLarge),
      leading:
          isLeading
              ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color:
                      themeController.themeMode.value == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                ),
              )
              : SizedBox.shrink(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child:
              isAction
                  ? InkWell(
                onTap: onAction,
                    child: Icon(
                      actionIcon,
                      size: 30,
                      color:
                          themeController.themeMode.value == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  )
                  : SizedBox.shrink(),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
