import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/gamification/badges/badge_controller.dart';
import 'package:hobby_club_app/controller/club/gamification/points/points_controller.dart';
import 'package:hobby_club_app/controller/club/gamification/points/total_point_controller.dart';
import 'package:hobby_club_app/controller/club/gamification/redeem/redeem_controller.dart';
import 'package:hobby_club_app/controller/theme/theme_controller.dart';
import 'package:hobby_club_app/models/club/gamification/redeem/redeem_model.dart';
import 'package:hobby_club_app/view/gamification/badges_page.dart';
import 'package:hobby_club_app/view/gamification/points_page.dart';
import 'package:hobby_club_app/view/gamification/rewards_page.dart';
import 'package:hobby_club_app/view/screens/Referrals/club_referral_screen.dart';
import 'package:hobby_club_app/view/screens/club/club_members_screen.dart';
import 'package:hobby_club_app/view/screens/club/helper/points_helper.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/image_view.dart';
import 'package:shimmer/shimmer.dart';

class ClubInfoPage extends StatefulWidget {
  final String clubId;
  final String clubImage;
  final String clubName;
  final String clubDesc;
  final String clubMembers;

  const ClubInfoPage({
    super.key,
    required this.clubId,
    required this.clubImage,
    required this.clubName,
    required this.clubDesc,
    required this.clubMembers,
  });

  @override
  State<ClubInfoPage> createState() => _ClubInfoPageState();
}

class _ClubInfoPageState extends State<ClubInfoPage> {
  ThemeController themeController = Get.find<ThemeController>();
  final badgeController = Get.put(BadgeController());
  final pointsController = Get.put(PointsController());
  final totalPointController = Get.put(TotalPointController());
  final redeemController = Get.put(RedeemController());

  @override
  void initState() {
    super.initState();
    badgeController.fetchBadgesDetails(clubId: widget.clubId);
    pointsController.fetchPointsDetails(clubId: widget.clubId);
    totalPointController.fetchTotalPoints(clubId: widget.clubId);
    redeemController.fetchRedeemReward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Club Info',
        centerTitle: true,
        isLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildClubDetails(),
            SizedBox(height: 10),
            _buildClubMembersDetails(themeController),
            SizedBox(height: 10),
            _buildClubReferralMembersDetails(themeController),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Your Progress',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Obx(() {
              if (totalPointController.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 120, height: 16, color: Colors.white),
                            Container(width: 60, height: 16, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final totalPoints = totalPointController.clubTotalPointsModel.value?.data.totalPoints ?? 0;
              final progress = PointsHelper.getPointsProgress(totalPoints);

              return Padding(
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
                          '${progress['current']}/${progress['target']}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress['progress'],
                        backgroundColor: Color(0xFFD3DEE4),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Badges', style: Theme.of(context).textTheme.bodyLarge),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => BadgesPage(
                          badgeModel: badgeController.badgeModel.value!,
                        ),
                      );
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
            Obx(() {
              if (badgeController.isLoading.value) {
                return _buildBadgeShimmerGrid();
              }

              final badges = badgeController.badgeModel.value?.data ?? [];
              if (badges.isEmpty) {
                return _buildEmptyState(30, 'No clubs badges found');
              }

              return SizedBox(
                height: 220,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: badges.length > 2 ? 2 : badges.length,
                  itemBuilder: (context, index) {
                    final badge = badges[index];
                    return _badgeItem(
                      imageUrl: badge.image,
                      title: badge.title,
                    );
                  },
                ),
              );
            }),
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
                    onTap: () {
                      Get.to(
                        () => PointsPage(
                          pointModel: pointsController.pointModel.value!,
                        ),
                      );
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
            Obx(() {
              if (pointsController.isLoading.value) {
                return _pointsItemShimmer();
              }

              final points = pointsController.pointModel.value?.data ?? [];
              if (points.isEmpty) {
                return _buildEmptyState(30, 'No clubs points found');
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: points.length > 4 ? 4 : points.length,
                itemBuilder: (context, index) {
                  final point = points[index];
                  return _pointsItem(
                    label: point.title,
                    value: '+${point.points} points',
                  );
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rewards', style: Theme.of(context).textTheme.bodyLarge),
                  InkWell(
                    onTap: () {
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
            Obx(() {
              if (redeemController.isLoading.value) {
                return Column(
                  children: [
                    _rewardItemShimmer(),
                    _rewardItemShimmer(),
                  ],
                );
              }
              if (redeemController.errorMessage.value.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(redeemController.errorMessage.value),
                );
              }
              final rewards = redeemController.clubRedeemModel.value?.data ?? [];
              if (rewards.isEmpty) {
                return Column(
                  children: [
                    _rewardItem(
                      icon: Icons.confirmation_num_outlined,
                      title: 'No rewards available',
                      subtitle: 'Check back later',
                    ),
                  ],
                );
              }
              final displayRewards = rewards.length > 2 ? rewards.sublist(rewards.length - 2) : rewards;
              return Column(
                children: displayRewards.map((reward) {
                  return _rewardItem(
                    icon: _getRewardIcon(reward.type),
                    title: reward.title,
                    subtitle: 'Redeem ${_getRewardPoints(reward)} points',
                  );
                }).toList(),
              );
            }),
            // Padding(
            //   padding: Dimensions.screenPaddingHorizontal.copyWith(
            //     bottom: 20,
            //     top: 20,
            //   ),
            //   child: CustomElevatedButton(
            //     title: 'Leave Club',
            //     onTap: (){},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _badgeItem({required String imageUrl, required String title}) {
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
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildBadgeShimmerGrid() {
    return SizedBox(
      height: 220,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        // Number of shimmer items
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(height: 14, width: 80, color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _pointsItem({required String label, required String value}) {
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
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _pointsItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFD3DEE4), width: 1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Container(height: 16, color: Colors.white),
            ),
            Expanded(child: Container(height: 16, color: Colors.white)),
          ],
        ),
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
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
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

  IconData _getRewardIcon(String type) {
    switch (type) {
      case 'voucher':
        return Icons.confirmation_num_outlined;
      case 'certificate':
        return Icons.card_membership;
      case 'gift':
        return Icons.card_giftcard;
      default:
        return Icons.star_outline;
    }
  }

  int _getRewardPoints(RewardRedeem reward) {
    switch (reward.type) {
      case 'voucher':
        return reward.voucherPoints ?? 0;
      case 'certificate':
        return reward.certificatePoints ?? 0;
      case 'gift':
        return reward.giftPoints ?? 0;
      default:
        return 0;
    }
  }

  Widget _rewardItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 150,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClubDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color:
            Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(
                () => ImageView(image: widget.clubImage, title: 'Club Image'),
              );
            },
            child: Container(
              width: Get.width,
              height: 218,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.clubImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                widget.clubName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.clubDesc,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClubMembersDetails(final themeController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 5,
            children: [
              Text(
                'Club Members:',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.clubMembers,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.to(() => ClubMembersView(clubId: widget.clubId));
            },
            child: Icon(
              Icons.forward_rounded,
              size: 30,
              color:
                  themeController.themeMode.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubReferralMembersDetails(final themeController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                ? Colors.grey[800]
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 5,
            children: [
              Text(
                'Referral Members',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.to(() => ReferralScreen(clubId: widget.clubId));
            },
            child: Icon(
              Icons.forward_rounded,
              size: 30,
              color:
                  themeController.themeMode.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(double height, String message) {
    return SizedBox(height: height, child: Center(child: Text(message)));
  }
}
