// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hobby_club_app/utils/app_colors.dart';
// import 'package:hobby_club_app/utils/dimensions.dart';
// import 'package:hobby_club_app/utils/style.dart';
// import 'package:hobby_club_app/view/screens/auth/notification_permission_screen.dart';
// import 'package:hobby_club_app/view/widgets/custom_button.dart';

// class CountryLanguageSelectionScreen extends StatelessWidget {
//   const CountryLanguageSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Image.asset(AppImages.bg2, fit: BoxFit.cover),
//           Padding(
//             padding: Dimensions.screenPaddingHorizontal,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(),
//                 //welcme
//                 Text("Welcome", style: AppStyles.extraLargeHeading),
//                 Text(
//                   textAlign: TextAlign.center,
//                   'Choose a country and your preferred language to get started',
//                   style: AppStyles.greysubtitle,
//                 ),
//                 SizedBox(height: 30),
//                 // country
//                 Container(
//                   padding: EdgeInsets.all(13),
//                   decoration: BoxDecoration(
//                     color: AppColors.textfieldcolor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     spacing: 5,
//                     children: [
//                       //country
//                       Text('Country', style: AppStyles.body),
//                       Spacer(),
//                       Text('Pakistan', style: AppStyles.greysubtitle),
//                       Icon(Icons.keyboard_arrow_right, color: Colors.black),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // language
//                 Container(
//                   padding: EdgeInsets.all(13),
//                   decoration: BoxDecoration(
//                     color: AppColors.textfieldcolor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     spacing: 5,
//                     children: [
//                       //country
//                       Text('Language', style: AppStyles.body),
//                       Spacer(),
//                       Text('English', style: AppStyles.greysubtitle),
//                       Icon(Icons.keyboard_arrow_right, color: Colors.black),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 CustomButton(
//                   text: 'Continue',
//                   onPressed: () {
//                     Get.to(() => NotificationPermissionScreen());
//                   },
//                 ),
//                 SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
