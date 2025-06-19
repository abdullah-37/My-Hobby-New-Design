import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/dimensions.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.wifi_slash, size: Dimensions.icon48),
            Text("No Internet"),
          ],
        ),
      ),
    );
  }
}
