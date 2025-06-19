import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:hobby_club_app/utils/constants.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';


class MessageContainer extends StatelessWidget {
  final bool isSent;
  final String message;
  final String userName;
  final String time;
  final bool isImage;

  const MessageContainer({
    super.key,
    required this.isSent,
    required this.message,
    required this.userName,
    required this.time,
    required this.isImage,
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
            if (isSent) const SizedBox(width: 30),

            // profile picture
            if (!isSent) const CustomNetworkImage(size: 45, imageUrl: "image"),
            //Colum of username and message
            Expanded(
              child: Column(
                spacing: 3,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: isSent
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  //username
                  Text(
                    isSent ? "You" : userName,
                    style: TextStyle(
                      fontSize: Dimensions.font14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //message container
                  Column(
                    crossAxisAlignment: isSent
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: isSent
                              ? AppColors.primary.withValues(alpha: 0.2)
                              : const Color(0xFFebefed),
                          borderRadius: BorderRadius.circular(
                            Constants.chatContainerRadius,
                          ),
                        ),
                        child: isImage
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Constants.chatContainerRadius,
                                ),
                                child: Image.asset(AppImages.dummyimage),
                              )
                            : Text(
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
            if (isSent) const CustomNetworkImage(size: 45, imageUrl: "image"),
            if (!isSent) const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
