import 'package:flutter/material.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeWidth;
  static double _blockSizeHeight;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;

  static String deviceOrientation;

  void init(BoxConstraints constraints, Orientation orientation) {
    deviceOrientation = orientation.toString();

    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }

    _blockSizeWidth = _screenWidth / 100;
    _blockSizeHeight = _screenHeight / 100;

    textMultiplier = _blockSizeHeight;
    imageSizeMultiplier = _blockSizeWidth;
    heightMultiplier = _blockSizeHeight;

    print("Width $_blockSizeWidth");
    print("Heigth $_blockSizeHeight");
  }

  static isPotrait() {
    return deviceOrientation == Orientation.portrait.toString();
  }

  static isLandscapte() {
    return deviceOrientation == Orientation.landscape.toString();
  }
}
