import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/theme_controller.dart';
import 'package:hobby_club_app/view/gamification/badges_page.dart';
import 'package:hobby_club_app/view/gamification/leaderboard_page.dart';
import 'package:hobby_club_app/view/gamification/points_page.dart';
import 'package:hobby_club_app/view/gamification/rewards_page.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class GamificationPage extends StatefulWidget {
  const GamificationPage({super.key});

  @override
  State<GamificationPage> createState() => _GamificationPageState();
}

class _GamificationPageState extends State<GamificationPage> {
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Gamification',centerTitle: true,isLeading: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Your Progress',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Points to next level',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '600/1000',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Color(0xFFD3DEE4),
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Badges',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => BadgesPage());
                    },
                    child: Text(
                      'Visit All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        letterSpacing: -0.015,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _badgeItem(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAFRygq7C7utDKEMIRhZmEDY_3T6Jfp3YnMgVK83BCNM_YZgZBaaoBSfi1UODjdC2pdcNZfS0SWivbzc1AbUJq-KkcLVpWyWNGsl10HPGBKHqHSdkqtZ9Afl3xKjYouDAl5Ddn7M_2JXYdQVlhmGWYtn_tfFBhCqZ4IiPjPWhouiVhKjNawp9OcHmzOj4L6LXhQVWojFvpMVKzMw-TPkVkCwVkuo_abWBciCKUMiRrzFJOzucBbwDubAh-3GJ1EhaTEDPAKFp27oG4c',
                    'First Timer',
                  ),
                  _badgeItem(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBkH3qoz9AeFNsOFeeJw8FodJJpi63evstRJVKOKAdf_YHVJflZcXIKz0TFHCFyKsN3WO-aBy_b1ePcFM5zCD99NBxmxGnfKY0gJRympoR9QXQIsTe9OrfJo4ZDo4xp0h5m7nhJcvpVagmVFO-XzzBhg-dqrcJcAIeqMYdYPwKIi8ii_lQsVlQdbWaHeUaDSq0AzCErfIXUCwPe95fwmMOs6uRLuXBxeVuyBvFyZRvzNdW3rcKkYRTMdb8ZM958m_30ub59i75vu_si',
                    'Active Member',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Points System',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => PointsPage());
                    },
                    child: Text(
                      'Visit All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        letterSpacing: -0.015,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _pointsItem('Event Attendance', '+50 points'),
                  _pointsItem('Social Posts', '+20 points'),
                  _pointsItem(
                    'Challenge Completion',
                    '+100 points',
                  ),
                  _pointsItem('Invite Colleagues', '+30 points'),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Leaderboard',
            //         style: TextStyle(
            //           fontSize: 22,
            //           fontWeight: FontWeight.bold,
            //           color: primaryTextColor,
            //           letterSpacing: -0.015,
            //         ),
            //       ),
            //       InkWell(
            //         onTap: (){
            //           Get.to(() => LeaderboardScreen());
            //         },
            //         child: Text(
            //           'Visit All',
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.grey,
            //             letterSpacing: -0.015,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Column(
            //   children: [
            //     _leaderboardItem(
            //       'https://lh3.googleusercontent.com/aida-public/AB6AXuBOvd_8JmW3eORlb49UrEvzlS-t-Uu53eiHLuu2Xr0Ne3N__JougRS8RK-wLXnTsF8R160yky3RxNzzc6oUfgGI9I15CT-pWERI88coPPMvODWP5CYQh94ES5tPSt9XAzOppVQu7ArXCNcsZvhTCvvA1pU_iQAyTx7ySlPZFFT_35sNGG4f0IU_irkhOLn0P1dGzcvXTwq0m8lsYMrPbH7D09N6EZKgdgQWEedMgx1oce6uGUXc6eM4U22GDZ2eQDgFNI_13ifnkJpQ',
            //       'Ethan Carter',
            //       '1200 points',
            //     ),
            //     _leaderboardItem(
            //       'https://lh3.googleusercontent.com/aida-public/AB6AXuDsvRETYkJWOtCV64l4MI0lFcl1p1gpTUKvuZfBO_9Scy0sKXecjXsTuJYNLPnZr2GJ1unXUb3lNUSN8RMAhRx_97gQW66aN93cQSIkUesx3jqKODWiOBfRdrEb5cOf0BX58DT0M8d8s6LMyVw8mbdBwJG35beoKUw9E4FrS1k7GuLMMDCqOJFcIq5c1oOnXpZ4lIzOGvfq4-LBlcDv579Vcs99AgT2eeKElZRIGXnIq7bMxQMGVQj4sI9D-tT4IpA8jSNDpmXtcG3L',
            //       'Sophia Bennett',
            //       '1100 points',
            //     ),
            //     _leaderboardItem(
            //       'https://lh3.googleusercontent.com/aida-public/AB6AXuBu2m20Wcg_m4kaWlUXVoRc-qding2JWRTEPLJ7tD4U86opOD8EPVAlO18rIeK1Fp7YwplJJvs2wX3gIYmOMne48ZUeAK26GGa2dL45yy8YqVAVLj6JucLTPPx8YeQovDu---o6Uorz-9-5RtzRjtjhW3r4YFxI0nu4ME4kg1AsZAaxrCgvq-y8KVhPvB4813g4Fx5VBu3xuGEUJFjNCrUsglZ2flmthhywhL9v4f5n8lDxPPMJcfj3eTgig0yUlVznw1fiVLkzdy9d',
            //       'Liam Harper',
            //       '1000 points',
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rewards',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => RewardsScreen());
                    },
                    child: Text(
                      'Visit All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        letterSpacing: -0.015,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _rewardItem(
                  icon: Icons.confirmation_num_outlined,
                  title: 'Exclusive Event Access',
                  subtitle: 'Redeem 1000 points',
                ),
                _rewardItem(
                  icon: Icons.percent,
                  title: 'Merchandise Discount',
                  subtitle: 'Redeem 500 points',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badgeItem(String imageUrl, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _pointsItem(String label, String value,) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFD3DEE4), width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: const Color(0xFF577C8E)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _leaderboardItem(String imageUrl, String name, String points) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF101619),
                  ),
                ),
                Text(
                  points,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF577C8E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFE9EFF1),
            ),
            child: Icon(icon, color: const Color(0xFF101619)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF577C8E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
