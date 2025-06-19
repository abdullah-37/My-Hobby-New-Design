import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/book_club_controller.dart';
import 'package:hobby_club_app/controller/post/like_controller.dart';
import 'package:hobby_club_app/models/club/all_clubs_model.dart';
import 'package:hobby_club_app/models/club/club_model.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/chat%20view/chat_screen.dart';
import 'package:hobby_club_app/view/screens/posts/comments_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

class JoinedClubDetailScreen extends StatefulWidget {
  final int id;
  const JoinedClubDetailScreen({super.key, required this.id});

  @override
  State<JoinedClubDetailScreen> createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<JoinedClubDetailScreen> {
  @override
  void initState() {
    Get.put(BookClubController());
    Get.put(LikeController());
    Get.find<BookClubController>().fetchClubFeed(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments;
    final allClub = argument is AllClub ? argument : null;
    final club = argument is Club ? argument : null;

    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.bookClub, isLeading: true),
      bottomNavigationBar: Padding(
        padding: Dimensions.screenPaddingHV,
        child: CustomButton(
          text: AppStrings.message,
          onPressed: () {
            Get.to(() => ChatScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: GetBuilder<BookClubController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: Dimensions.screenPaddingHV,
                  child: Column(
                    children: [
                      // CustomClubCard(
                      //   eventsCount: 3,
                      //   membersCount:
                      //       (allClub?.totalMembers ?? club?.membersCount ?? '0')
                      //           .toString(),
                      //   imageUrl: club?.img ?? allClub?.img ?? '',
                      //   title: allClub?.title ?? club?.title ?? 'No Title',
                      //   subtitle:
                      //       '${allClub?.totalMembers ?? club?.membersCount ?? '0'} ${AppStrings.members}',
                      //   status: '',
                      //   desc: club?.desc ?? allClub?.desc ?? 'No description',
                      // ),
                      // SizedBox(height: Dimensions.height20),
                      // Align(
                      //   alignment: AlignmentDirectional.centerStart,
                      //   child: Text(
                      //     'Description:',
                      //     style: TextStyle(color: AppColors.primary,fontSize: 20,fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // Text(
                      //   club?.desc ?? allClub?.desc ?? 'No description',
                      //   style: AppStyles.body,
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: Dimensions.screenPaddingHV,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.clubFeedModel?.data.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = controller.clubFeedModel?.data[index];
                      if (data == null) return const SizedBox();

                      return Padding(
                        padding: EdgeInsets.only(bottom: Dimensions.padding30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomNetworkImage(
                                  size: Dimensions.width60,
                                  imageUrl: data.profile.img ?? '',
                                ),
                                SizedBox(width: Dimensions.width5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data.profile.firstName ?? ''} ${data.profile.lastName ?? ''}",
                                      style: AppStyles.mediumText.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "@${data.profile.userName}",
                                      style: AppStyles.mediumText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Text(
                              data.desc,
                              style: AppStyles.mediumText,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: Dimensions.height10),
                            if (data.image != null)
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius15),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: data.image!,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) => Image.asset(
                                        "assets/images/error_image.jpg",
                                      ),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            SizedBox(height: Dimensions.height10),
                            GetBuilder<LikeController>(
                              builder:
                                  (likeController) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final clubId =
                                              allClub?.id ?? club?.id;
                                          if (clubId != null) {
                                            await likeController
                                                .likePost(
                                                  clubId,
                                                  data.id,
                                                  data.isLike ? 0 : 1,
                                                )
                                                .then((_) {
                                                  controller.fetchClubFeed(
                                                    clubId,
                                                  );
                                                });
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              data.isLike
                                                  ? CupertinoIcons.heart_fill
                                                  : CupertinoIcons.heart,
                                              color:
                                                  data.isLike
                                                      ? Colors.red
                                                      : null,
                                            ),
                                            SizedBox(width: Dimensions.width5),
                                            Text("${data.likes ?? 0}"),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.bottomSheet(
                                            ignoreSafeArea: false,
                                            backgroundColor: Colors.white,
                                            CommentsScreen(
                                              comments: data.comments ?? [],
                                            ),
                                            isScrollControlled: true,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.comment_outlined),
                                            SizedBox(width: Dimensions.width5),
                                            Text('${data.comments.length}'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        controller.timeAgoSince(data.updatedAt),
                                      ),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
