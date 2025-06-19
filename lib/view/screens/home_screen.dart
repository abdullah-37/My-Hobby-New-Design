// main_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/navigation_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/view/activities%20view/event_screen.dart.dart';
import 'package:hobby_club_app/view/calender_view/calender.dart';
import 'package:hobby_club_app/view/screens/posts/post_screen.dart';
import 'package:hobby_club_app/view/screens/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> pages = [
    WelcomeScreen(),
    EventsScreen(),
    CustomCalendar(),
    PostScreen(),
    // CustomCalendar(),
    // ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.event_available), label: "Events"),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: "Calender",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.white,
        body: pages[navController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: navController.currentIndex.value,
          onTap: navController.changeTab,
          items: items,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
