import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
  }
}

double getScreenHeight(int height) {
  double screenHeight = SizeConfig.screenHeight;
  return (height / 812) * screenHeight;
}

double getScreenWidth(int width) {
  double screenWidth = SizeConfig.screenWidth;
  return (width / 375) * screenWidth;
}
