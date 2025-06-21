import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';
import 'package:hobby_club_app/view/widgets/header_widget.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({super.key});

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;

  @override
  Widget build(BuildContext context) {
    double headerHeight = 300;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(color: Colors.white),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: headerHeight,
              child: HeaderWidget(
                headerHeight,
                true,
                Icons.privacy_tip_outlined,
              ),
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verification',
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge!.copyWith(fontSize: 40),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Enter the verification code we just sent you on your email address.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Pinput(
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            onCompleted: (pin) {
                              if (mounted) {
                                setState(() {
                                  _pinSuccess = true;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 50.0),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            //child: Text('Don\'t have an account? Create'),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Did not recieved code? "),
                                  TextSpan(
                                    text: 'Resend',
                                    recognizer:
                                        TapGestureRecognizer()..onTap = () {},
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
                          const SizedBox(height: 40.0),
                          Container(
                            decoration:
                                _pinSuccess
                                    ? ThemeHelper().buttonBoxDecoration(context)
                                    : ThemeHelper().buttonBoxDecoration(
                                      context,
                                      "#AAAAAA",
                                      "#757575",
                                    ),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              onPressed:
                                  _pinSuccess
                                      ? () {
                                        // Navigate to next screen
                                      }
                                      : null,
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "VERIFY",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
