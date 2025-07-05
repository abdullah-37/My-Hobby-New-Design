import 'package:flutter/material.dart';
import 'package:hobby_club_app/models/club/gamification/badges/badges_model.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class BadgesPage extends StatefulWidget {
  final BadgeModel badgeModel;
  const BadgesPage({super.key, required this.badgeModel});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Badges',centerTitle: true,isLeading: true,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Text(
              'Earned Badges',
                style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: _isLoading
                ? _buildShimmerGrid()
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.76,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: widget.badgeModel.data.length,
              itemBuilder: (context, index) {
                final badge = widget.badgeModel.data[index];
                return _badgeItem(
                  title: badge.title,
                  type: badge.type,
                  imageUrl: badge.image,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgeItem({required String imageUrl, required String title, required String type}) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
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
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            type,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4E7F97),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.76,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  height: 14,
                  width: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}