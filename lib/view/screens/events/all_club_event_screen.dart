import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club_event_controller.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/activities%20view/event_details_page.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/event_widget.dart';
import 'package:hobby_club_app/view/screens/events/create_event_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:shimmer/shimmer.dart';

class AllClubEventScreen extends StatefulWidget {

  AllClubEventScreen({super.key});

  @override
  State<AllClubEventScreen> createState() => _AllClubEventScreenState();
}

class _AllClubEventScreenState extends State<AllClubEventScreen> {
  final ClubEventController clubEventController = Get.put(
    ClubEventController(),
  );

  @override
  void initState() {
    clubEventController.allClubEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Events',
        isLeading: false,
      ),
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: Obx(() {
          if (clubEventController.isLoading.value) {
            return _buildLoadingIndicator(200);
          }

          final events = clubEventController.clubEventModel.value?.data ?? [];
          if (events.isEmpty) {
            return _buildEmptyState(200, 'No Event is Available Yet!');
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventWidget(
                event: event,
                onAction: () {
                  Get.to(() => EventDetailsPage(eventDetail: event));
                },
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildLoadingIndicator(double height) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 100, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 16, width: 140, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(height: 14, width: 120, color: Colors.white),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 14, width: 100, color: Colors.white),
                          Container(height: 14, width: 60, color: Colors.white),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 10 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(double height, String message) {
    return SizedBox(height: height, child: Center(child: Text(message)));
  }
}
