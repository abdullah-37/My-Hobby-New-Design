import 'package:flutter/material.dart';
import 'package:hobby_club_app/utils/theme/theme_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isLoading;
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeHelper().buttonBoxDecoration(context),
      width: double.infinity,
      child: ElevatedButton(
        style: ThemeHelper().buttonStyle(),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Padding(
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
