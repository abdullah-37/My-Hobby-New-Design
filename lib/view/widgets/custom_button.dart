import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      width: double.infinity,
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
