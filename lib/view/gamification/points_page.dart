import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Points',centerTitle: true,isLeading: true,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'How to earn points',
                style: Theme.of(context).textTheme.displayLarge,
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
                  style: Theme.of(context).textTheme.bodyLarge,
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
