import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/models/events_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/activities%20view/widgets/rsvp_dialogue_widget.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMMM, dd yyyy');
    const Color subtitleColor = Color.fromARGB(255, 95, 95, 95);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomAppBarTitle(title: 'Activity Details'),
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.scaffoldBG,
      ),
      body: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //image
          // Image.asset(
          //   AppImages.dummyimage,
          //   height: 200,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          // ),
          Center(
            child: CachedNetworkImage(
              imageUrl: event.img,
              errorWidget:
                  (context, url, error) =>
                      const Center(child: Icon(Icons.image, size: 40)),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          //title for event
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font24,
                      ),
                    ),
                    //
                    Text(
                      '${DateFormat('EEEE').format(event.date)}, ${formatter.format(event.date)} -  ${event.startTime} - ${event.endTime}',
                      style: TextStyle(
                        color: subtitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font14,
                      ),
                    ),

                    /// locations
                    Row(
                      spacing: 15,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on),
                          ),
                        ),
                        Text(
                          event.location,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                      ],
                    ),

                    // Descriptions
                    Text(
                      event.desc,
                      style: TextStyle(
                        color: subtitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font17,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // orgaizer
                    Text(
                      'Organizer',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font20,
                      ),
                    ),

                    // organizer name
                    Row(
                      spacing: 8,
                      children: [
                        //Circle Avatar
                        CustomNetworkImage(
                          size: 55,
                          imageUrl: event.profile.img,
                        ),
                        Text(
                          event.profile.userName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font17,
                          ),
                        ),
                      ],
                    ),
                    // additional notes
                    Text(
                      'Additional Notes',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font17,
                      ),
                    ),
                    // additional note description
                    Text(
                      event.note,
                      style: TextStyle(
                        color: subtitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font14,
                      ),
                    ),

                    // rsvp
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: CustomButton(
              text: "RSVP",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (contetx) => const RsvpDialogueWidget(),
                );
              },
            ),
          ),
          // const SizedBox(height: 30),
        ],
      ),
    );
  }
}
