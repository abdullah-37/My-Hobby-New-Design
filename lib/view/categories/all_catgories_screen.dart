import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/categories/category_controller.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/categories/explore_clubs_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final categoryController = Get.put(CategoryController());
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<dynamic> _filterCategories(List<dynamic> categories) {
    if (_searchQuery.isEmpty) {
      return categories;
    }
    return categories.where((category) {
      return category.title.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'All Categories'),
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: Column(
          children: [
            _buildSearchField(context),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (categoryController.isLoading.value) {
                  return _buildLoadingIndicator();
                }

                final categories = categoryController.categoryModel.value?.data ?? [];
                final filteredCategories = _filterCategories(categories);

                if (filteredCategories.isEmpty) {
                  return _buildEmptyState(
                      _searchQuery.isEmpty
                          ? 'No categories found'
                          : 'No results for "$_searchQuery"'
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5 / 1,
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                              () => ExploreClubsScreen(
                            categoryName: category.title,
                            categoryId: category.id.toString(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                category.image,
                                width: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                category.title,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        prefixIcon: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.search,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                const SizedBox(width: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: VerticalDivider(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
          },
        )
            : null,
        hintText: 'Search Categories'.tr,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey,
        ),
      ),
    );
  }
}