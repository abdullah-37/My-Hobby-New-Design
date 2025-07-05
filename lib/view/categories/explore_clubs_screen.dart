import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/categories/category_club_controller.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/screens/club/category_club_details_page.dart';
import 'package:hobby_club_app/view/screens/club/joined_club_detail_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class ExploreClubsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const ExploreClubsScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<ExploreClubsScreen> createState() => _ExploreClubsScreenState();
}

class _ExploreClubsScreenState extends State<ExploreClubsScreen> {
  final categoryClubController = Get.put(CategoryClubController());
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;

  @override
  void initState() {
    categoryClubController.categoryClub(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.categoryName),
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: Column(
          children: [
            categoryClubSearchField(),
            SizedBox(height: 10),
            Obx(() {
              if (categoryClubController.isLoading.value) {
                return Expanded(child: _buildShimmerEffect());
              }
              final allClubs =
                  categoryClubController.categoryClubModel.value?.data ?? [];
              final filteredClubs =
                  allClubs.where((club) {
                    return club.title.toLowerCase().contains(
                      _searchQuery.value,
                    );
                  }).toList();

              if (filteredClubs.isEmpty) {
                return _buildEmptyState(30, 'No clubs found!');
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2.2 / 3,
                  ),
                  itemCount: filteredClubs.length,
                  itemBuilder: (context, index) {
                    final club = filteredClubs[index];
                    return GestureDetector(
                      onTap: () {
                        debugPrint('club.isJoined == ${club.isJoined}');
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
                          Get.to(() => CategoryClubDetailsPage(club: club));
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                club.img,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            club.title,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Members: ${club.totalMembers}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF9daebe),
                                ),
                              ),
                              Text(
                                'Events: ${club.totalSchedules}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF9daebe),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.2 / 3,
      ),
      itemBuilder:
          (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(height: 12, width: 100, color: Colors.grey.shade300),
                const SizedBox(height: 6),
                Container(height: 12, width: 80, color: Colors.grey.shade300),
              ],
            ),
          ),
    );
  }

  Widget categoryClubSearchField() {
    return TextFormField(
      controller: _searchController,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        prefixIcon: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: VerticalDivider(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        hintText: 'Search Clubs'.tr,
      ),
      onChanged: (v) {
        _searchQuery.value = v.trim().toLowerCase();
      },
    );
  }

  Widget _buildEmptyState(double height, String message) {
    return SizedBox(height: height, child: Center(child: Text(message)));
  }
}
