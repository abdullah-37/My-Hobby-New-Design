import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/view/activities%20view/event_details_page.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});

  final Map<String, String> event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          Get.to(() => EventDetailsPage());
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),

          decoration: BoxDecoration(
            // border: Border.all(color: Theme.of(context).primaryColor),
            // borderRadius: BorderRadius.circular(Dimensions.cardRadius),
          ),
          child: Row(
            children: [
              // Text Section
              Expanded(
                flex: 2,
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['date'] ?? '',
                      style: TextStyle(
                        color: Color(0xFF6A7681),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      event['title'] ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      event['location'] ?? '',
                      style: TextStyle(color: Color(0xFF6A7681), fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Participants: ${event['Participants'] ?? ''}',
                          style: TextStyle(
                            color: Color(0xFF6A7681),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          event['isParticipated'] == 'true'
                              ? 'Joined'
                              : 'Not Joined',
                          style: TextStyle(
                            color:
                                event['isParticipated'] == 'true'
                                    ? Colors.green
                                    : Color(0xFF6A7681),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // Image Section
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 10 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      event['image'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
