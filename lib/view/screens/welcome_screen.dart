import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/categories/category_controller.dart';
import 'package:hobby_club_app/controller/club/my_join_club_controller.dart';
import 'package:hobby_club_app/controller/club/trending_club_controller.dart';
import 'package:hobby_club_app/view/categories/all_catgories_screen.dart';
import 'package:hobby_club_app/view/categories/explore_clubs_screen.dart';
import 'package:hobby_club_app/view/screens/club/club_details_page.dart';
import 'package:hobby_club_app/view/screens/club/create_club_screen.dart';
import 'package:hobby_club_app/view/screens/club/joined_club_detail_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final trendingClubController = Get.put(TrendingClubController());
  final categoryController = Get.put(CategoryController());
  final joinClubController = Get.put(MyJoinClubController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        isLeading: false,
        actionIcon: Icons.add,
        isAction: true,
        onAction: () {
          Get.to(() => CreateClubScreen());
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trending Clubs Section
              _buildSectionHeader('Trending Clubs'),
              _buildTrendingClubs(),

              // Explore Clubs Section
              _buildExploreHeader(),
              _buildExploreCategories(),

              // My Clubs Section
              _buildSectionHeader('My Clubs'),
              _buildMyClubs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.displayLarge),
    );
  }

  Widget _buildExploreHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore Clubs',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          InkWell(
            onTap: () {
              Get.to(() => AllCategoriesScreen());
            },
            child: Text(
              'Visit All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingClubs() {
    return Obx(() {
      if (trendingClubController.isLoading.value) {
        return _buildLoadingIndicator(220);
      }

      final clubs = trendingClubController.trendingClubModel.value?.data ?? [];
      if (clubs.isEmpty) {
        return _buildEmptyState(30, 'No trending clubs found');
      }

      return SizedBox(
        height: 220,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: clubs.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final club = clubs[index];
            return _buildClubCard(
              image: club.img,
              title: club.title,
              members: club.totalMembers,
              events: club.totalSchedules,
              onTap: () {
                if (club.isJoined == true) {
                  Get.to(
                    () => JoinedClubDetailScreen(
                      clubId: club.id.toString(),
                      clubImage: club.img,
                      clubName: club.title,
                      clubDesc: club.desc,
                      clubMembers: club.totalMembers.toString(),
                    ),
                  );
                } else {
                  Get.to(() => ClubDetailsPage(club: club));
                }
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildExploreCategories() {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return _buildLoadingIndicator(80);
      }

      final categories = categoryController.categoryModel.value?.data ?? [];
      if (categories.isEmpty) {
        return _buildEmptyState(80, 'No categories found');
      }

      return SizedBox(
        height: 80,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryItem(
              image: category.image,
              title: category.title,
              onTap:
                  () => Get.to(
                    () => ExploreClubsScreen(
                      categoryName: category.title,
                      categoryId: category.id.toString(),
                    ),
                  ),
            );
          },
        ),
      );
    });
  }

  Widget _buildMyClubs() {
    return Obx(() {
      if (joinClubController.isLoading.value) {
        return _buildLoadingIndicator(200);
      }

      final clubs = joinClubController.joinClub.value?.data ?? [];
      if (clubs.isEmpty) {
        return _buildEmptyState(200, 'You did not join any clubs yet');
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: clubs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final club = clubs[index];
          return _buildJoinedClubCard(
            image: club.img,
            category: club.category,
            title: club.title,
            description: club.desc,
            members: club.totalMembers,
            events: club.totalSchedules,
            onTap:
                () => Get.to(
                  () => JoinedClubDetailScreen(
                    clubId: club.id.toString(),
                    clubImage: club.img,
                    clubName: club.title,
                    clubDesc: club.desc,
                    clubMembers: club.totalMembers.toString(),
                  ),
                ),
          );
        },
      );
    });
  }

  Widget _buildClubCard({
    required String image,
    required String title,
    required int members,
    required int events,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 165,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildErrorImage();
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$members members · $events events',
              style: const TextStyle(fontSize: 13, color: Color(0xFF9daebe)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.network(
              image,
              width: 40,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorImage(size: 40);
              },
            ),
            const SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinedClubCard({
    required String image,
    required String category,
    required String title,
    required String description,
    required int members,
    required int events,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Members: $members',
                        style: const TextStyle(
                          color: Color(0xFF5C748A),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Events: $events',
                        style: const TextStyle(
                          color: Color(0xFF5C748A),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 10 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildErrorImage();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(double height) {
    if (height == 220) {
      return SizedBox(
        height: 220,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder:
              (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: SizedBox(
                  width: 165,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(height: 16, width: 100, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(height: 12, width: 80, color: Colors.white),
                    ],
                  ),
                ),
              ),
        ),
      );
    } else if (height == 80) {
      return SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder:
              (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(width: 40, height: 12, color: Colors.white),
                  ],
                ),
              ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder:
            (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                ),
              ),
            ),
      );
    }
  }

  Widget _buildEmptyState(double height, String message) {
    return SizedBox(height: height, child: Center(child: Text(message)));
  }

  Widget _buildErrorImage({double size = double.infinity}) {
    return Container(
      color: Colors.grey[800],
      width: size,
      height: size,
      child: const Icon(Icons.broken_image, color: Colors.white),
    );
  }
}
