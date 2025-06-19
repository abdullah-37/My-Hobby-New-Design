import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Dimensions {
  // dimensions beign used in news design
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;
  // Padding
  static EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: screenWidth * 0.05,
  );
  static double font26 = screenHeight / 30.14;
  static double font18 = screenHeight / 41.8;

  /////////////////////////////////////////////////////////////////////

  // Dynamic heights (based on 844px design height)
  static double height2 = screenHeight / 422;
  static double height5 = screenHeight / 168.8;
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height25 = screenHeight / 33.76;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  static double height50 = screenHeight / 16.88;
  static double height60 = screenHeight / 14.07;
  static double height65 = screenHeight / 12.98;
  static double height100 = screenHeight / 8.44;
  static double height120 = screenHeight / 7.03;
  static double height200 = screenHeight / 4.22;
  static double height250 = screenHeight / 3.38;

  // Dynamic widths (based on 390px design width)
  static double width5 = screenWidth / 78;
  static double width10 = screenWidth / 39;
  static double width15 = screenWidth / 26;
  static double width20 = screenWidth / 19.5;
  static double width30 = screenWidth / 13;
  static double width45 = screenWidth / 8.67;
  static double width50 = screenWidth / 7.8;
  static double width60 = screenWidth / 6.94;
  static double width65 = screenWidth / 6.1;
  static double width70 = screenWidth / 5.36;
  static double width75 = screenWidth / 4.63;
  static double width80 = screenWidth / 4.0;
  static double width100 = screenWidth / 3.9;
  static double width120 = screenWidth / 3.25;

  // Font sizes (scaled to screen height)
  static double font5 = screenHeight / 168.8;
  static double font10 = screenHeight / 84.4;
  static double font12 = screenHeight / 70.3;
  static double font14 = screenHeight / 56.27;
  static double font16 = screenHeight / 52.75;
  static double font17 = screenHeight / 48.2;
  static double font19 = screenHeight / 40.2;
  static double font20 = screenHeight / 38.13;
  static double font22 = screenHeight / 35.17;
  static double font24 = screenHeight / 32.17;
  // static double font26 = screenHeight / 30.14;
  static double font28 = screenHeight / 28.13;
  static double font30 = screenHeight / 28.13;
  static double font34 = screenHeight / 24.5;
  static double font36 = screenHeight / 22.5;
  static double font40 = screenHeight / 16.88;
  static double font44 = screenHeight / 17.18;

  // Border radii
  static double buttonRadius = screenHeight / 42.2;
  static double cardRadius = screenHeight / 46.2;
  static double inputRadius = screenHeight / 168.8;
  static double radius8 = screenHeight / 105.5;
  static double radius10 = screenHeight / 84.4;
  static double radius15 = screenHeight / 56.27;
  static double radius30 = screenHeight / 28.13;
  static double radius50 = screenHeight / 16.88;

  // Icon sizes
  static double icon16 = screenHeight / 52.75;
  static double icon20 = screenHeight / 42.2;
  static double icon24 = screenHeight / 35.17;
  static double icon28 = screenHeight / 30.14;
  static double icon32 = screenHeight / 26.38;
  static double icon36 = screenHeight / 22.5;
  static double icon38 = screenHeight / 21.5;
  static double icon40 = screenHeight / 16.88;
  static double icon44 = screenHeight / 15.5;
  static double icon48 = screenHeight / 14.07;

  // If you also want vertical padding:
  static EdgeInsets screenPaddingHV = EdgeInsets.symmetric(
    horizontal: screenWidth * 0.06,
    vertical: screenHeight * 0.02,
  );

  // If you also want horizontal padding:
  static EdgeInsets screenPaddingH = EdgeInsets.symmetric(
    horizontal: screenWidth * 0.06,
  );

  // If you also want horizontal padding:
  static EdgeInsets screenPaddingV = EdgeInsets.symmetric(
    vertical: screenHeight * 0.02,
  );

  static EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: Get.width * 0.05,
    vertical: Get.height * 0.025,
  );

  static double padding5 = height5;
  static double padding10 = height10;
  static double padding15 = height15;
  static double padding20 = height20;
  static double padding25 = height25;
  static double padding30 = height30;
}
