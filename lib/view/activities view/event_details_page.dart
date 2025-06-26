import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/models/club_event_model.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';

class EventDetailsPage extends StatelessWidget {
  final ClubEvent eventDetail;

  const EventDetailsPage({super.key, required this.eventDetail});

  @override
  Widget build(BuildContext context) {
    final secondaryTextColor = const Color(0xFF60768a);
    final borderColor = const Color(0xFFDBE1E6);

    return Scaffold(
      appBar: CustomAppBar(title: 'Event Detail'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 218,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(eventDetail.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: Dimensions.screenPaddingHorizontal,
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      eventDetail.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      eventDetail.shortDesc,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(fontSize: 13),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _detailRow(
                          'Date',
                          eventDetail.date,
                          // 'Saturday, July 20',
                          borderColor,
                          context,
                        ),
                        _detailRow(
                          'Time',
                          '${eventDetail.startTime} - ${eventDetail.endTime}',
                          // '9:00 AM - 3:00 PM',
                          borderColor,
                          context,
                        ),
                        _detailRow(
                          'Location',
                          eventDetail.location,
                          // 'Mountain Trailhead',
                          borderColor,
                          context,
                        ),
                      ],
                    ),
                    Text(
                      eventDetail.desc,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Organizer',
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(eventDetail.profile.img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventDetail.profile.userName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              eventDetail.clubTitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if(eventDetail.note.isNotEmpty)
                    Text(
                      'Instructions',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      eventDetail.note,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomElevatedButton(onTap: () {}, title: 'Join Event'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value,
    Color borderColor,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width * 0.2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
