import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static final double prototypeWidth = 375;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double sizeByPixel(double pixel) {
    return screenWidth * (pixel / prototypeWidth);
  }
}
