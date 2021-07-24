import 'package:flutter/material.dart';

class ScreenLayout {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;
  static double statusBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    statusBarHeight = _mediaQueryData.padding.top;
  }
}
