import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/discussions/discussion_details_controller.dart';
import 'package:hobby_club_app/models/discussions_details_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_images.dart';
import 'package:hobby_club_app/utils/constants.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';
import 'package:hobby_club_app/view/discussion%20view/widgets/reply_discussion_widget.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

class DisussionDetailScreen extends StatelessWidget {
  const DisussionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DiscussionDetailsController discussionDetailsController = Get.put(
      DiscussionDetailsController(),
    );

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.back(result: true);
        //   },
        //   child: const Icon(Icons.arrow_back),
        // ),
        backgroundColor: AppColors.scaffoldBG,
        title: const FittedBox(
          child: CustomAppBarTitle(title: "Elections: Date of Club Elections"),
        ),
      ),
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: Obx(
          () =>
              discussionDetailsController.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      DiscussionDetailWidget(
                        image:
                            discussionDetailsController
                                .discussionReplies[0]
                                .profile
                                .img,
                        time: discussionDetailsController.timeAgoSince(
                          discussionDetailsController
                              .discussionReplies[0]
                              .createdAt
                              .toString(),
                        ),
                        totalReplies:
                            discussionDetailsController
                                .discussionReplies[0]
                                .replies
                                .length,
                        username:
                            discussionDetailsController
                                .discussionReplies[0]
                                .profile
                                .userName,
                        description:
                            discussionDetailsController
                                .discussionReplies[0]
                                .desc,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Replies',
                        style: TextStyle(
                          fontSize: Dimensions.font19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      discussionDetailsController
                              .discussionReplies[0]
                              .replies
                              .isEmpty
                          ? const Expanded(
                            child: Center(child: Text('No Replies :(')),
                          )
                          : Expanded(
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              child: ListView.builder(
                                itemCount:
                                    discussionDetailsController
                                        .discussionReplies[0]
                                        .replies
                                        .length,
                                itemBuilder: (context, index) {
                                  DiscussionReply reply =
                                      discussionDetailsController
                                          .discussionReplies[0]
                                          .replies[index];
                                  return ReplyDiscussionWidget(
                                    message: reply.reply,
                                    userName: reply.userName,
                                    time: discussionDetailsController
                                        .timeAgoSince(
                                          reply.createdAt.toString(),
                                        ),
                                    image: reply.image,
                                  );
                                },
                              ),
                            ),
                          ),
                      // const Spacer(),
                      // reply field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: TextField(
                                controller:
                                    discussionDetailsController
                                        .textReplyController,
                                onTap: () {
                                  // scrollController.
                                },
                                // onTapOutside: (e) {
                                //   FocusManager.instance.primaryFocus?.unfocus();
                                // },
                                maxLines: 5,
                                minLines: 1,
                                // expands: true,
                                cursorColor: AppColors.primary,
                                onChanged: (v) {
                                  // print(object)
                                },
                                decoration: InputDecoration(
                                  // suffixIcon: const Icon(Icons.camera_alt_outlined),
                                  // suffix: Image.asset('assets/camera_icon.png'),
                                  suffixIconConstraints: const BoxConstraints(
                                    maxHeight: 4,
                                    maxWidth: 2,
                                  ),

                                  isDense: true,
                                  hintText: "Type a Message",
                                  hintStyle: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                  fillColor: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                      Constants.chatContainerRadius,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (discussionDetailsController
                                    .textReplyController
                                    .text
                                    .isNotEmpty) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  discussionDetailsController.postReply();
                                } else {
                                  print('pppppppp empty text field');
                                }
                              },
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.send,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
        ),
      ),
    );
  }
}

class DiscussionDetailWidget extends StatelessWidget {
  final String username;
  final String description;
  final int totalReplies;
  final String time;
  final String image;

  const DiscussionDetailWidget({
    super.key,
    required this.username,
    required this.description,
    required this.totalReplies,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // border: Border.all(color: Colors.black),
        // color: Colors.red,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          // profile picture
          // const CircleAvatar(
          //   backgroundColor: Color.fromARGB(255, 221, 178, 3),
          //   radius: 25,
          // ),
          CustomNetworkImage(size: 45, imageUrl: image),
          //Colum of username and message
          Expanded(
            child: Column(
              // spacing: 3,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //username
                Text(
                  username,
                  style: TextStyle(
                    fontSize: Dimensions.font18,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //message container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        // color: const Color(0xFFebefed),
                        borderRadius: BorderRadius.circular(
                          Constants.chatContainerRadius,
                        ),
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(AppImages.replies, height: 20),
                        const SizedBox(width: 5),
                        Text(
                          '$totalReplies',
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: TextStyle(fontSize: Dimensions.font14),
                        ),
                      ],
                    ),
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
    );
  }
}
