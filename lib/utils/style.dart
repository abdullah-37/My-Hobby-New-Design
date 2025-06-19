import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'dimensions.dart';

class AppStyles {
  // static TextStyle get extraLargeHeading => TextStyle(
  //   fontSize: Dimensions.font44,
  //   fontWeight: FontWeight.bold,
  //   color: AppColors.primary,
  // );

  // static TextStyle get largeHeading => TextStyle(
  //   fontSize: Dimensions.font24,
  //   fontWeight: FontWeight.w500,
  //   color: AppColors.primary,
  // );

  static TextStyle get heading => TextStyle(
    fontSize: Dimensions.font22,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get subHeading => TextStyle(
    fontSize: Dimensions.font19,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  // static TextStyle get body => TextStyle(
  //   fontSize: Dimensions.font18,
  //   color: AppColors.primary,
  //   fontWeight: FontWeight.w400,
  // );

  static TextStyle get boldBody => TextStyle(
    fontSize: Dimensions.font18,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get mediumText => TextStyle(
    fontSize: Dimensions.font17,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get suffixText => TextStyle(
    fontSize: Dimensions.font16,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  // Comments style
  static TextStyle get commentUsernameText =>
      TextStyle(fontSize: Dimensions.font16, fontWeight: FontWeight.bold);

  static TextStyle get commentBodyText =>
      TextStyle(fontSize: Dimensions.font14);
  static TextStyle get commentSmallText =>
      TextStyle(fontSize: Dimensions.font12, color: Colors.grey.shade600);
  /////////////////////////////

  static TextStyle get buttonText => TextStyle(
    fontSize: Dimensions.font18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get inputHint =>
      TextStyle(fontSize: Dimensions.font18, color: AppColors.inputHintText);

  static TextStyle get cardTitle => TextStyle(
    fontSize: Dimensions.font22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: AppColors.white,
  );

  static TextStyle get cardSubTitle => TextStyle(
    fontSize: Dimensions.font18,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get eventDate =>
      const TextStyle(fontSize: 14, color: AppColors.inputHintText);

  //////////////////////////////////////////////////////////////////////////
  static TextStyle get extraLargeHeading => TextStyle(
    fontSize: Dimensions.font30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle get largeHeading => TextStyle(
    fontSize: Dimensions.font24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle get greysubtitle =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.grey);
  static TextStyle get body =>
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15);

  ///
}
