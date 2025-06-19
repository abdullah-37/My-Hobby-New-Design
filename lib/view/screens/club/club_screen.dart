import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/club/clubs_controller.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/recommended_club_card.dart';

import 'create_club_screen.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  @override
  void initState() {
    Get.put(ClubsController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(title: AppStrings.clubs),
        bottomNavigationBar: Padding(
          padding: Dimensions.screenPaddingHV,
          child: CustomButton(
            text: AppStrings.createClub,
            onPressed: () {
              Get.to(() => CreateClubScreen());
            },
          ),
        ),
        body: GetBuilder<ClubsController>(
          builder:
              (controller) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.background,
                      padding: Dimensions.screenPaddingHorizontal.copyWith(
                        bottom: Dimensions.height30,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                          vertical: Dimensions.height5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius10,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              color: AppColors.inputHintText,
                            ),
                            SizedBox(width: Dimensions.width10),
                            Expanded(
                              child: TextField(
                                controller: controller.searchController,
                                onChanged: (value) {
                                  controller.onSearchChanged();
                                },
                                onSubmitted: (value) {
                                  controller.onSearchChanged();
                                },
                                decoration: InputDecoration(
                                  hintText: AppStrings.searchClubs,
                                  hintStyle: AppStyles.inputHint,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.white,
                      padding: Dimensions.screenPaddingHorizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.height20),
                          Text(
                            AppStrings.recommended,
                            style: AppStyles.cardTitle,
                          ),

                          SizedBox(height: Dimensions.height10),

                          controller.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.allClubs.length,
                                separatorBuilder:
                                    (context, index) =>
                                        SizedBox(height: Dimensions.height5),
                                itemBuilder: (context, index) {
                                  var data = controller.allClubs[index];
                                  return RecommendedClubCard(
                                    imageUrl: data.img ?? "",
                                    title: data.title ?? "",
                                    subtitle: data.desc ?? "",
                                    onTap: () {
                                      // Get.to(
                                      //   // () => BookClubScreen(id: data.id!),
                                      //   // arguments: data,
                                      // );
                                    },
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
