// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hobby_club_app/utils/app_images.dart';
// import 'package:hobby_club_app/utils/dimensions.dart';
// import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
// import 'package:hobby_club_app/view/screens/auth/sign_up_screen.dart';
// import 'package:hobby_club_app/view/widgets/custom_button.dart';
// import 'package:hobby_club_app/view/widgets/toggle_theme_widget.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

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
//               spacing: 10,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(),
//                 // logo  of user
//                 Image.asset(
//                   AppImages.user,
//                   height: Dimensions.screenHeight * 0.2,
//                   width: Dimensions.screenWidth * 0.4,
//                 ),
//                 // heading
//                 Text(
//                   'already_have_an_account'.tr,
//                   style: Theme.of(context).textTheme.displayLarge,
//                 ),
//                 //description
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Text(
//                     textAlign: TextAlign.center,
//                     'see_your_profile'.tr,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: Dimensions.font14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 //login button
//                 Spacer(),
//                 CustomButton(
//                   text: 'login'.tr,
//                   onPressed: () {
//                     Get.to(() => LoginScreen());
//                   },
//                 ),
//                 // SizedBox(height: 15),

//                 // create account button
//                 CustomButton(
//                   text: 'create_account'.tr,
//                   onPressed: () {
//                     Get.to(() => SignUpScreen());
//                   },
//                   color: Colors.black.withValues(alpha: 0.3),
//                 ),
//                 SizedBox(height: 30),
//               ],
//             ),
//           ),
//           // Positioned(top: 40, right: 20, child: ThemeToggleButton()),
//         ],
//       ),
//     );
//   }
// }
