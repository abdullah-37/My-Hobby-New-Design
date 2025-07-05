import 'package:flutter/material.dart';
import 'package:hobby_club_app/models/club/club_event_model.dart';

class EventWidget extends StatelessWidget {
  final Function()? onAction;
  final ClubEvent event;
  const EventWidget({super.key, required this.event, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event.date} ${event.startTime}',
                    style: TextStyle(
                      color: Color(0xFF6A7681),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    event.location,
                    style: TextStyle(color: Color(0xFF6A7681), fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Participants: ${event.totalParticipations}',
                        style: TextStyle(
                          color: Color(0xFF6A7681),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        event.isParticipating == true
                            ? 'Joined'
                            : 'Not Joined',
                        style: TextStyle(
                          color:
                              event.isParticipating == true
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
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 10 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    event.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
