import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/constants.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

class ReplyDiscussionWidget extends StatelessWidget {
  // final bool isSent;
  final String message;
  final String userName;
  final String time;
  final String image;
  // final bool isImage;

  const ReplyDiscussionWidget({
    super.key,
    // required this.isSent,
    required this.message,
    required this.userName,
    required this.time,
    required this.image,

    // required this.isImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          // border: Border.all(color: Colors.black),
          // color: Colors.red,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            // if (isSent) const SizedBox(width: 30),

            // profile picture
            CustomNetworkImage(size: 45, imageUrl: image),

            //Colum of username and message
            Expanded(
              child: Column(
                spacing: 3,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //username
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: Dimensions.font14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //message container
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: const Color(0xFFebefed),
                          borderRadius: BorderRadius.circular(
                            Constants.chatContainerRadius,
                          ),
                        ),
                        child: Text(
                          message,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                      ),
                      Text(time, style: TextStyle(fontSize: Dimensions.font12)),
                    ],
                  ),
                ],
              ),
            ),
            // if (isSent)
            //   const CircleAvatar(
            //     backgroundColor: Color.fromARGB(255, 1, 177, 169),
            //     radius: 20,
            //   ),
            // if (!isSent) const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
