import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/events/evets_controller.dart';
import 'package:hobby_club_app/models/events_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/event_widget.dart';
import 'package:hobby_club_app/view/events%20view/event_details_screen.dart';
import 'package:intl/intl.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EvetsController evetsController = Get.put(EvetsController());
    return
    // Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: const CustomAppBarTitle(title: AppStrings.clubActivities),
    //     scrolledUnderElevation: 0,
    //     backgroundColor: AppColors.scaffoldBG,
    //   ),
    //   body:
    Obx(
      () =>
          evetsController.isLoading.value
              ? Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
              : evetsController.upcommingEvents.isEmpty
              ? Center(child: Text('No Upcomming events'))
              : ListView.builder(
                shrinkWrap: true,
                itemCount: evetsController.upcommingEvents.length,
                itemBuilder: (context, index) {
                  EventModel event = evetsController.upcommingEvents[index];
                  final formatter = DateFormat('MMMM, dd yyyy');
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => EventDetailsScreen(event: event));
                    },
                    child: EventWidget(
                      isJoined: event.isPrticipated,
                      name: event.title,
                      clubName: event.clubName,
                      description: event.desc,
                      date: formatter.format(event.date),
                      day: DateFormat('EEEE').format(event.date),
                      time: '${event.startTime} - ${event.endTime}',
                      participants: event.totalParticipants,
                    ),
                  );
                },
              ),
    );
  }
}

// assuming Dimensions.font20, font14, etc.
