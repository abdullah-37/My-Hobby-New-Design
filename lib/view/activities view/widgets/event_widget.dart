import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/constants.dart';
import 'package:hobby_club_app/utils/dimensions.dart';

class EventWidget extends StatelessWidget {
  final String name;
  final String description;
  final String date; // e.g. "June 10, 2025"
  final String day; // e.g. "Wednesday"
  final String time; // e.g. "3:00 PM"
  final int participants; // e.g. 42
  final bool isJoined;
  final String clubName;

  const EventWidget({
    super.key,
    required this.name,
    required this.isJoined,
    required this.description,
    required this.date,
    required this.day,
    required this.time,
    required this.participants,
    required this.clubName,
  });

  @override
  Widget build(BuildContext context) {
    // const Color subtitleColor = Color.fromARGB(255, 95, 95, 95);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.forumContainerRadius),
          color: AppColors.primary.withOpacity(0.01),
          border: Border.all(color: AppColors.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity or Event Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // const Icon(
                    //   Icons.access_time,
                    //   size: 16,
                    //   color: AppColors.primary,
                    // ),
                    const SizedBox(width: 4),
                    // Text(
                    //   time,
                    //   style: TextStyle(
                    //     color: AppColors.subtitleColor,

                    //     fontSize: Dimensions.font14,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Description
            Text(
              description,
              maxLines: 1,

              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.subtitleColor,
                fontSize: Dimensions.font14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Club Name: ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  clubName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Date, Day, and Time row
            Row(
              children: [
                // Date
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                          color: AppColors.subtitleColor,

                          fontSize: Dimensions.font14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Day
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.today,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.subtitleColor,
                          fontSize: Dimensions.font14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Time
                // Expanded(
                //   child: Row(
                //     children: [
                //       const Icon(
                //         Icons.access_time,
                //         size: 16,
                //         color: AppColors.primary,
                //       ),
                //       const SizedBox(width: 4),
                //       Text(
                //         time,
                //         style: TextStyle(
                //           color: subtitleColor,
                //           fontSize: Dimensions.font14,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 8),

            // Number of Participants
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  '$participants people participated',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,

                    color: AppColors.subtitleColor,
                    fontSize: Dimensions.font14,
                  ),
                ),
                const Spacer(),
                if (isJoined)
                  const Text(
                    "Joined",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
