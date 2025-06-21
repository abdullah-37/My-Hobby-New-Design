import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/screens/auth/forgot_verification.dart';
import 'package:hobby_club_app/view/screens/auth/login_screen.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double headerHeight = 300;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: headerHeight,
              child: HeaderWidget(headerHeight, true, Icons.password_rounded),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge!.copyWith(fontSize: 40),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Enter the email address associated with your account.',
                            style: TextStyle(color: Colors.grey),
                            // textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We will email you a verification code to check your authenticity.',
                            style: TextStyle(color: Colors.grey),
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                          SizedBox(height: 40.0),
                          Container(
                            decoration: ThemeHelper().buttonBoxDecoration(
                              context,
                            ),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  40,
                                  10,
                                  40,
                                  10,
                                ),
                                child: Text(
                                  "Send".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ForgotPasswordVerificationPage(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text('Don\'t have an account? Create'),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Remember your password? "),
                                  TextSpan(
                                    text: 'Log In',
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => LoginScreen(),
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
