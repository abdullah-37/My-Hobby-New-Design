import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/club_event_controller.dart';
import 'package:hobby_club_app/models/club/club_event_model.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';

class EventDetailsPage extends StatefulWidget {
  final ClubEvent eventDetail;
  final int userId;

  const EventDetailsPage({super.key, required this.eventDetail, required this.userId});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final clubEventController = Get.put(ClubEventController());

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
                    image: NetworkImage(widget.eventDetail.img),
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
                      widget.eventDetail.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      widget.eventDetail.shortDesc,
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
                          widget.eventDetail.date,
                          // 'Saturday, July 20',
                          borderColor,
                          context,
                        ),
                        _detailRow(
                          'Time',
                          '${widget.eventDetail.startTime} - ${widget.eventDetail.endTime}',
                          // '9:00 AM - 3:00 PM',
                          borderColor,
                          context,
                        ),
                        _detailRow(
                          'Location',
                          widget.eventDetail.location,
                          // 'Mountain Trailhead',
                          borderColor,
                          context,
                        ),
                      ],
                    ),
                    Text(
                      widget.eventDetail.desc,
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
                              image: NetworkImage(
                                widget.eventDetail.profile.img,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.eventDetail.profile.userName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              widget.eventDetail.clubTitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (widget.eventDetail.note.isNotEmpty)
                      Text(
                        'Instructions',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    Text(
                      widget.eventDetail.note,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (widget.eventDetail.profile.userId != widget.userId)
                      Obx(() {
                        debugPrint('${widget.eventDetail.profile.userId} != ${widget.userId}');
                      final event = clubEventController.clubEventModel.value?.data.firstWhere(
                            (e) => e.id == widget.eventDetail.id,
                        orElse: () => widget.eventDetail,
                      );

                      return CustomElevatedButton(
                        onTap: () async {
                          bool success = await clubEventController.joinClubEvent(
                            clubId: event.clubId.toString(),
                            isParticipate: event.isParticipating == true ? '0' : '1',
                            scheduleId: event.id.toString(),
                          );
                          if (success) {
                            Get.back();
                          }
                        },
                        title: event!.isParticipating == true ? 'Leave Event' : 'Join Event',
                        isLoading: clubEventController.isLoading.value,
                      );
                    }),
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
