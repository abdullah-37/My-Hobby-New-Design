import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/utils/app_strings.dart';
import 'package:hobby_club_app/utils/dimensions.dart';
import 'package:hobby_club_app/utils/style.dart';
import 'package:hobby_club_app/view/screens/posts/comments_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_appbar.dart';
import 'package:hobby_club_app/view/widgets/custom_network_image.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.bookClub),
      body: Padding(
        padding: Dimensions.screenPaddingHV,
        child: ListView(
          children: [
            Column(
              spacing: Dimensions.height10,
              children: [
                Row(
                  spacing: Dimensions.width5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomNetworkImage(
                      size: Dimensions.width60,
                      imageUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1z3WO2y5h7YkHljxIsvwuOxP21OE_8tnedA&s",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Name",
                          style: AppStyles.mediumText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("@username", style: AppStyles.mediumText),
                      ],
                    ),
                  ],
                ),
                Text(
                  "data data datad datadata data data data data datadatadatadata datadata data datadata data datadatadatadata datadata data data",
                  style: AppStyles.mediumText,
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius15),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1z3WO2y5h7YkHljxIsvwuOxP21OE_8tnedA&s",
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) =>
                            Image.asset("assets/images/error_image.jpg"),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [Icon(CupertinoIcons.heart), Text("20")],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [Icon(Icons.comment_outlined), Text("50")],
                      ),
                    ),
                    Text("2 hour ago"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
