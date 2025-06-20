import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 48,
                      height: 48,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color(0xFF0E171B),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 48),
                        child: Text(
                          'Points',
                          style: TextStyle(
                            color: Color(0xFF0E171B),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.015,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'How to earn points',
                  style: TextStyle(
                    color: Color(0xFF0E171B),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  PointsItem(
                    icon: Icons.calendar_today,
                    title: 'Attend events',
                    subtitle: 'Earn 10 points',
                  ),
                  PointsItem(
                    icon: Icons.image,
                    title: 'Post in the feed',
                    subtitle: 'Earn 5 points',
                  ),
                  PointsItem(
                    icon: Icons.emoji_events,
                    title: 'Complete challenges',
                    subtitle: 'Earn 20 points',
                  ),
                  PointsItem(
                    icon: Icons.people,
                    title: 'Invite colleagues',
                    subtitle: 'Earn 15 points',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PointsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PointsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 72,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE7EFF3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: const Color(0xFF0E171B)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0E171B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF4E7F97),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
