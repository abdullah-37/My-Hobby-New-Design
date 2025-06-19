import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/book_club_controller.dart';
import 'package:hobby_club_app/controller/post/comment_controller.dart';
import 'package:hobby_club_app/models/club/club_feed_model.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';
import 'package:hobby_club_app/view/widgets/custom_text_form_field.dart';

class CommentsScreen extends StatelessWidget {
  final List<Comment> comments;

  const CommentsScreen({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateCommentController());
    BookClubController controller = Get.find();
    return SafeArea(
      child: GetBuilder<CreateCommentController>(
        builder:
            (commentController) => Column(
              children: [
                SizedBox(height: Dimensions.height10),
                Text(AppStrings.comments, style: AppStyles.largeHeading),
                Expanded(
                  child:
                      comments.isNotEmpty
                          ? Padding(
                            padding: Dimensions.screenPaddingHV,
                            child: ListView.separated(
                              itemCount: comments.length,
                              separatorBuilder:
                                  (context, index) =>
                                      SizedBox(height: Dimensions.height10),
                              itemBuilder: (context, index) {
                                Comment comment = comments[index];
                                return commentItem(
                                  image: comment.profile.img,
                                  name: comment.profile.userName,
                                  time: controller.timeAgoSince(
                                    comment.updatedAt,
                                  ),
                                  text: comment.comment,
                                );
                              },
                            ),
                          )
                          : Center(child: Text(AppStrings.noComments)),
                ),
                Container(
                  padding: Dimensions.screenPaddingHV,
                  decoration: BoxDecoration(color: AppColors.background),
                  child: Row(
                    spacing: Dimensions.width10,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: AppStrings.addComments,
                          controller: commentController.commentController,
                          focusNode: commentController.commentFocus,
                          maxLines: 10,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            // Handle comment submission
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget commentItem({
    required String image,
    required String name,
    required String time,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.height10),
      child: Row(
        spacing: Dimensions.width10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(size: Dimensions.width50, imageUrl: ""),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: AppStyles.commentUsernameText),
                    Text(time, style: AppStyles.commentSmallText),
                  ],
                ),
                SizedBox(height: Dimensions.height5),
                Text(text, style: AppStyles.commentBodyText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
