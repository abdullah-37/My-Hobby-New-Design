import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/common/navigation_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:hobby_club_app/view/calender_view/calender.dart';
import 'package:hobby_club_app/view/screens/events/all_club_event_screen.dart';
import 'package:hobby_club_app/view/screens/profile/profile_screen.dart';
import 'package:hobby_club_app/view/screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> pages = [
    WelcomeScreen(),
    AllClubEventScreen(),
    CustomCalendar(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int selectedIndex = navController.currentIndex.value;

      return Scaffold(
        // backgroundColor: AppColors.white,
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          // backgroundColor: AppColors.white,
          currentIndex: selectedIndex,
          onTap: navController.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 0 ? AppImages.house : AppImages.houseun,
                height: 25,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 1 ? AppImages.events : AppImages.eventsun,
                height: 25,
              ),
              label: "Events",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 2 ? AppImages.calender : AppImages.calenderun,
                height: 25,
              ),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                selectedIndex == 3 ? AppImages.setting : AppImages.settingun,
                height: 25,
              ),
              label: "Settings",
            ),
          ],
        ),
      );
    });
  }
}
