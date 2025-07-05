import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/club/gamification/points/points_model.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class PointsPage extends StatefulWidget {
  final PointModel pointModel;

  const PointsPage({super.key, required this.pointModel});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
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
      appBar: CustomAppBar(title: 'Points', centerTitle: true, isLeading: true),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Earn points',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          Expanded(
            child:
                _isLoading
                    ? pointsItemShimmer()
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.pointModel.data.length,
                      itemBuilder: (context, index) {
                        final point = widget.pointModel.data[index];
                        return pointsItem(
                          label: point.title,
                          value: 'Earn ${point.points} points',
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget pointsItem({required String label, required String value}) {
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

  Widget pointsItemShimmer() {
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
              width: Get.width * 0.5,
              child: Container(height: 16, color: Colors.white),
            ),
            Expanded(child: Container(height: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
