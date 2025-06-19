import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/discussions/discussions_controller.dart';
import 'package:hobby_club_app/models/discussion_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/constants.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';
import 'package:hobby_club_app/view/discussion%20view/disussion_detail_screen.dart';
import 'package:hobby_club_app/view/discussion%20view/widgets/create_discussion_dialogue_widget.dart';

class DiscussionScreen extends StatelessWidget {
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DiscussionsController discussionsController = Get.put(
      DiscussionsController(),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomAppBarTitle(title: AppStrings.discussions),
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.scaffoldBG,
      ),
      body: Padding(
        padding: Dimensions.screenPaddingHorizontal,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Obx(
              () => Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(),
                  Text(
                    AppStrings.currentdiscussions,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.font24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  discussionsController.isLoading.value
                      ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                      : discussionsController.discussions.isEmpty
                      ? Expanded(child: const Text('No Discussions available'))
                      : Expanded(
                        child: ListView.builder(
                          itemCount: discussionsController.discussions.length,
                          itemBuilder: (context, index) {
                            Discussions discussions =
                                discussionsController.discussions[index];
                            String formatedTime = discussionsController
                                .timeAgoSince(discussions.createdAt.toString());
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const DisussionDetailScreen(),
                                  arguments: {
                                    "clubId": 8,
                                    "discussionId": discussions.id,
                                  },
                                )!.then((result) {
                                  if (result == true) {
                                    discussionsController.getClubDiscussions(
                                      discussionsController.id,
                                    );
                                  }
                                });
                              },
                              child: DiscussionWidget(
                                title: discussions.title,
                                date: formatedTime,
                                replies: discussions.repliesCount,
                              ),
                            );
                          },
                        ),
                      ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController titleController =
                          TextEditingController();
                      TextEditingController descriptionController =
                          TextEditingController();
                      final formKey = GlobalKey<FormState>();

                      return CreateNewDiscussionWidget(
                        formKey: formKey,
                        titleController: titleController,
                        descriptionController: descriptionController,
                        discussionsController: discussionsController,
                      );
                    },
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(Icons.add, size: 25, color: Colors.white),
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

class DiscussionWidget extends StatelessWidget {
  final String title;
  final int replies;
  final String date;
  const DiscussionWidget({
    super.key,
    required this.date,
    required this.replies,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Constants.forumContainerRadius),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '#',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.font26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Dimensions.font18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  // const SizedBox(height: 4),
                  Text(
                    '$replies replies • $date',
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       '${AppStrings.postedby} Abdullah',
                  //       style: TextStyle(
                  //         fontSize: Dimensions.font12,
                  //         color: const Color.fromARGB(255, 93, 93, 93),
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
