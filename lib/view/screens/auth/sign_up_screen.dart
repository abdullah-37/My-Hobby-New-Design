import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/controller/auth/sign_up_controller.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<SignUpScreen> {
  bool checkedValue = false;
  bool checkboxValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(SignUpController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: GetBuilder<SignUpController>(
          builder: (controller) => Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                      child: HeaderWidget(
                        150,
                        false,
                        Icons.person_add_alt_1_rounded,
                      ),
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
                                SizedBox(height: 200),
                                Text(
                                  'Create Account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 40),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field is empty';
                                      }
                                      final emailRegex = RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      );
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    controller: controller.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    focusNode: controller.emailFocus,
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
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                    focusNode: controller.phoneFocus,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number is required';
                                      }
                                      if (value.length < 10) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
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
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    controller: controller.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    focusNode: controller.passwordFocus,
                                    obscureText: controller.obscurePassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
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
                                  decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                                  child: TextFormField(
                                    controller:
                                    controller.confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    focusNode: controller.confirmPasswordFocus,
                                    obscureText:
                                    controller.obscureConfirmPassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Confirm password is required';
                                      }
                                      if (value !=
                                          controller.passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
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
                                // SizedBox(height: 15.0),
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
                                //               side: BorderSide(
                                //                 color: Theme.of(context).brightness == Brightness.dark
                                //                     ? Colors.white
                                //                     : Colors.black,
                                //                 width: 2,
                                //               ),
                                //               fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                //                 if (states.contains(MaterialState.selected)) {
                                //                   return Theme.of(context).colorScheme.primary;
                                //                 }
                                //                 return Colors.transparent;
                                //               }),
                                //             ),
                                //             Text(
                                //               "I accept all terms and conditions.",
                                //               style: TextStyle(
                                //                 color: Colors.grey,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         Container(
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             state.errorText ?? '',
                                //             textAlign: TextAlign.left,
                                //             style: TextStyle(
                                //               color: Theme.of(context)
                                //                   .colorScheme
                                //                   .error,
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
                                SizedBox(height: 80.0),
                                CustomElevatedButton(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.register();
                                    }
                                    // if (_formKey.currentState!.validate() &&
                                    //     checkboxValue) {
                                    //   controller.register();
                                    // }
                                    // Get.to(() => ProfileCompleteScreen());
                                  },
                                  title: 'Register',
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account? ",
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    recognizer: TapGestureRecognizer()
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
                                      color:
                                      Theme.of(context).colorScheme.secondary,
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
              if (controller.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}