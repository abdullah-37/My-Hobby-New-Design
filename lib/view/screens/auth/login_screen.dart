import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobby_club_app/controller/auth/login_controller.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/screens/auth/forgot_password_screen.dart';
import 'package:hobby_club_app/view/screens/auth/sign_up_screen.dart';
import 'package:hobby_club_app/view/widgets/custom_button.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final double _headerHeight = 250;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: GetBuilder<LoginController>(
          builder: (controller) => Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: _headerHeight,
                      child: HeaderWidget(
                        _headerHeight,
                        true,
                        Icons.login_rounded,
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          children: [
                            Text(
                              'Welcome',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 40),
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
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: controller.emailFocus,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'field_is_empty'.tr;
                                        }
                                        final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        );
                                        if (!emailRegex.hasMatch(value)) {
                                          return 'enter_valid_email'.tr;
                                        }
                                        return null;
                                      },
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Field is empty';
                                        }
                                        return null;
                                      },
                                      controller: controller.passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      focusNode: controller.passwordFocus,
                                      obscureText: controller.obscurePassword,
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
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot your password?",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  CustomElevatedButton(
                                    title: 'Sign In',
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.login();
                                      }
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                      10,
                                      20,
                                      10,
                                      20,
                                    ),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Don't have an account? ",
                                          ),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpScreen(),
                                                  ),
                                                );
                                              },
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
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