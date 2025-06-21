// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:hobby_club_app/controller/auth/sign_up_controller.dart';
// import 'package:hobby_club_app/utils/app_colors.dart';
// import 'package:hobby_club_app/utils/app_images.dart';
// import 'package:hobby_club_app/utils/app_strings.dart';
// import 'package:hobby_club_app/utils/dimensions.dart';
// import 'package:hobby_club_app/utils/style.dart';
// import 'package:hobby_club_app/view/screens/auth/country_language_selection_screen.dart';
// import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
// import 'package:hobby_club_app/view/widgets/custom_button.dart';
// import 'package:hobby_club_app/view/widgets/custom_text_form_field.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     Get.put(SignUpController());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: GetBuilder<SignUpController>(
//           builder:
//               (controller) => Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Image.asset(AppImages.bg2, fit: BoxFit.cover),
//                   SingleChildScrollView(
//                     child: Padding(
//                       padding: Dimensions.screenPaddingHorizontal,
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(AppImages.signUp1),
//                             SizedBox(height: Dimensions.height200),
//                             Text(
//                               AppStrings.createAccount,
//                               style: AppStyles.extraLargeHeading.copyWith(),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: Dimensions.height20),
//                             CustomTextFormField(
//                               prefixIcon: Icons.mail,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Field is empty';
//                                 }

//                                 // Regular expression for email validation
//                                 final emailRegex = RegExp(
//                                   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                                 );

//                                 if (!emailRegex.hasMatch(value)) {
//                                   return 'Enter a valid email';
//                                 }

//                                 return null;
//                               },
//                               labelText: AppStrings.email,
//                               hintText: AppStrings.exampleMail,
//                               controller: controller.emailController,
//                               keyboardType: TextInputType.emailAddress,
//                               focusNode: controller.emailFocus,
//                               nextFocus: controller.phoneFocus,
//                               isRequired: false,
//                             ),
//                             // SizedBox(height: Dimensions.height10),
//                             CustomTextFormField(
//                               prefixIcon: Icons.phone,
//                               labelText: AppStrings.phone,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Phone number is required';
//                                 }
//                                 if (value.length < 10) {
//                                   return 'Enter a valid phone number';
//                                 }
//                                 return null;
//                               },
//                               hintText: AppStrings.exampleNumber,
//                               controller: controller.phoneController,
//                               keyboardType: TextInputType.phone,
//                               focusNode: controller.phoneFocus,
//                               nextFocus: controller.passwordFocus,
//                               isRequired: false,
//                             ),
//                             // SizedBox(height: Dimensions.height10),
//                             CustomTextFormField(
//                               prefixIcon: Icons.key,
//                               labelText: AppStrings.password,
//                               hintText: AppStrings.password,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Password is required';
//                                 }
//                                 if (value.length < 6) {
//                                   return 'Password must be at least 6 characters';
//                                 }
//                                 return null;
//                               },
//                               suffixIcon:
//                                   controller.obscurePassword
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                               controller: controller.passwordController,
//                               keyboardType: TextInputType.visiblePassword,
//                               focusNode: controller.passwordFocus,
//                               obscureText: controller.obscurePassword,
//                               onIconTap: controller.togglePasswordVisibility,
//                               nextFocus: controller.confirmPasswordFocus,
//                               isRequired: false,
//                             ),
//                             // SizedBox(height: Dimensions.height15),
//                             CustomTextFormField(
//                               prefixIcon: Icons.lock,
//                               labelText: AppStrings.confirmPassword,
//                               hintText: AppStrings.confirmPassword,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Confirm password is required';
//                                 }
//                                 if (value !=
//                                     controller.passwordController.text) {
//                                   return 'Passwords do not match';
//                                 }
//                                 return null;
//                               },
//                               suffixIcon:
//                                   controller.obscureConfirmPassword
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                               controller: controller.confirmPasswordController,
//                               keyboardType: TextInputType.visiblePassword,
//                               focusNode: controller.confirmPasswordFocus,
//                               obscureText: controller.obscureConfirmPassword,
//                               onIconTap:
//                                   controller.toggleConfirmPasswordVisibility,
//                               isRequired: false,
//                             ),
//                             SizedBox(height: Dimensions.height25),
//                             CustomButton(
//                               isLoading: controller.isLoading,
//                               text: AppStrings.signUp,
//                               onPressed: () {
//                                 // if (!controller.isLoading) {
//                                 //   if (_formKey.currentState!.validate()) {
//                                 //     controller.register();
//                                 //   }
//                                 // }

//                                 Get.to(() => CountryLanguageSelectionScreen());
//                               },
//                             ),
//                             SizedBox(height: Dimensions.height20),
//                             Row(
//                               spacing: 5,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   AppStrings.alreadyHaveAccount,
//                                   style: AppStyles.greysubtitle,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Get.to(() => LoginScreen());
//                                   },
//                                   child: Text(
//                                     AppStrings.logIn,
//                                     style: TextStyle(
//                                       color: AppColors.primary,
//                                       fontSize: 19,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 5,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Create Account',
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge!.copyWith(fontSize: 40),
                        ),
                        // SizedBox(height: 30),
                        // Container(
                        //   decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        //   child: TextFormField(
                        //     decoration: InputDecoration(
                        //       prefixIcon: Icon(
                        //         Icons.mail,
                        //         color: Colors.deepPurple.shade300,
                        //       ),
                        //       labelText: 'Email',
                        //       hintText: 'Enter your email',
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 30),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Theme.of(context).primaryColor,
                              ),
                              labelText: 'Phone number',
                              hintText: 'Enter your number',
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                              labelText: 'Confirm password',
                              hintText: 'Enter password again',
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        // FormField<bool>(
                        //   builder: (state) {
                        //     return Column(
                        //       children: <Widget>[
                        //         Row(
                        //           children: <Widget>[
                        //             Checkbox(
                        //               value: checkboxValue,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   checkboxValue = value!;
                        //                   state.didChange(value);
                        //                 });
                        //               },
                        //             ),
                        //             Text(
                        //               "I accept all terms and conditions.",
                        //               style: TextStyle(color: Colors.grey),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             state.errorText ?? '',
                        //             textAlign: TextAlign.left,
                        //             style: TextStyle(
                        //               color:
                        //                   Theme.of(context).colorScheme.error,
                        //               fontSize: 12,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        //   validator: (value) {
                        //     if (!checkboxValue) {
                        //       return 'You need to accept terms and conditions';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 20.0),
                        CustomElevatedButton(onTap: () {}, title: 'Register'),
                        SizedBox(height: 30.0),
                        Text(
                          "Or create account using social media",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 25.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 35,
                                  color: HexColor("#EC2D2F"),
                                ),
                                onTap: () {
                                  setState(() {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return ThemeHelper().alartDialog(
                                    //       "Google Plus",
                                    //       "You tap on GooglePlus social icon.",
                                    //       context,
                                    //     );
                                    //   },
                                    // );
                                  });
                                },
                              ),
                              SizedBox(width: 10.0),
                              Text('Continue with Google'),
                              // GestureDetector(
                              //   child: Container(
                              //     padding: EdgeInsets.all(0),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(100),
                              //       border: Border.all(
                              //         width: 5,
                              //         color: HexColor("#40ABF0"),
                              //       ),
                              //       color: HexColor("#40ABF0"),
                              //     ),
                              //     child: FaIcon(
                              //       FontAwesomeIcons.twitter,
                              //       size: 23,
                              //       color: HexColor("#FFFFFF"),
                              //     ),
                              //   ),
                              //   onTap: () {
                              //     setState(() {
                              //       showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return ThemeHelper().alartDialog(
                              //             "Twitter",
                              //             "You tap on Twitter social icon.",
                              //             context,
                              //           );
                              //         },
                              //       );
                              //     });
                              //   },
                              // ),
                              // SizedBox(width: 30.0),
                              // GestureDetector(
                              //   child: FaIcon(
                              //     FontAwesomeIcons.facebook,
                              //     size: 35,
                              //     color: HexColor("#3E529C"),
                              //   ),
                              //   onTap: () {
                              //     setState(() {
                              //       showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return ThemeHelper().alartDialog(
                              //             "Facebook",
                              //             "You tap on Facebook social icon.",
                              //             context,
                              //           );
                              //         },
                              //       );
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    //child: Text('Don\'t have an account? Create'),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: 'Sign In',
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
