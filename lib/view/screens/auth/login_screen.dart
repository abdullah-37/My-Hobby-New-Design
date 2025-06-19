// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hobby_club_app/controller/auth/login_controller.dart';
// import 'package:hobby_club_app/utils/app_colors.dart';
// import 'package:hobby_club_app/utils/app_strings.dart';
// import 'package:hobby_club_app/utils/dimensions.dart';
// import 'package:hobby_club_app/utils/style.dart';
// import 'package:hobby_club_app/view/screens/auth/sign_up_screen.dart';
// import 'package:hobby_club_app/view/widgets/custom_button.dart';
// import 'package:hobby_club_app/view/widgets/custom_text_form_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     Get.put(LoginController());
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: GetBuilder<LoginController>(
//           builder:
//               (controller) => Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Image.asset(AppImages.bg2, fit: BoxFit.cover),
//                   Padding(
//                     padding: Dimensions.screenPaddingHorizontal,
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(height: Dimensions.height45),
//                           Text(
//                             'login'.tr,
//                             style: AppStyles.extraLargeHeading,
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: Dimensions.height10),

//                           Text(
//                             'log_in_with_registered_email'.tr,
//                             style: AppStyles.greysubtitle,
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: Dimensions.height30),
//                           CustomTextFormField(
//                             prefixIcon: Icons.mail,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'field_is_empty'.tr;
//                               }

//                               // Regular expression for email validation
//                               final emailRegex = RegExp(
//                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                               );

//                               if (!emailRegex.hasMatch(value)) {
//                                 return 'enter_valid_email'.tr;
//                               }

//                               return null;
//                             },
//                             hintText: AppStrings.email,
//                             controller: controller.emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             focusNode: controller.emailFocus,
//                             nextFocus: controller.passwordFocus,
//                           ),
//                           SizedBox(height: Dimensions.height10),
//                           CustomTextFormField(
//                             prefixIcon: Icons.key,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Field is empty';
//                               }
//                               return null;
//                             },
//                             hintText: AppStrings.password,
//                             suffixIcon:
//                                 controller.obscurePassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                             controller: controller.passwordController,
//                             keyboardType: TextInputType.visiblePassword,
//                             focusNode: controller.passwordFocus,
//                             obscureText: controller.obscurePassword,
//                             onIconTap: controller.togglePasswordVisibility,
//                           ),
//                           SizedBox(height: Dimensions.height25),
//                           CustomButton(
//                             isLoading: controller.isLoading,
//                             text: AppStrings.logIn,
//                             onPressed: () {
//                               if (controller.isLoading) {
//                               } else {
//                                 if (_formKey.currentState!.validate()) {
//                                   controller.login();
//                                 }
//                               }
//                             },
//                           ),
//                           SizedBox(height: Dimensions.height30),
//                           Row(
//                             spacing: 5,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 AppStrings.dontHaveAccount,
//                                 style: AppStyles.greysubtitle,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.to(() => SignUpScreen());
//                                 },
//                                 child: Text(
//                                   AppStrings.signUp,
//                                   style: TextStyle(
//                                     color: AppColors.primary,
//                                     fontSize: 19,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/screens/auth/forgot_password_screen.dart';
import 'package:hobby_club_app/view/screens/auth/sign_up_screen.dart';
import 'package:hobby_club_app/view/screens/home_screen.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final double _headerHeight = 250;
  final Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(
                _headerHeight,
                true,
                Icons.login_rounded,
              ), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  10,
                ), // This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Email',
                                hintText: 'Enter your email',
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Theme.of(context).primaryColor,
                                ),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            // margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(
                              context,
                            ),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  'Sign In'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => HomeScreen());
                                // //After successful login we will redirect to profile page. Let's create profile page now
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProfilePage(),
                                //   ),
                                // );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text('Don\'t have an account? Create'),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => SignUpScreen(),
                                              ),
                                            );
                                          },
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
