import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color grey = Color(0xFF9E9E9E);

  static const Color accent = Color(0xFF4F8EF7);
  static const Color deleteColor = Color(0xFFFF5252);
  static const Color surfaceDark = Color(0xFF1A1A2E);

  static const Color sentenceAccent = Color(0xFF4F8EF7);
  static const Color wordAccent = Color(0xFF4CAF50);
  static const Color interviewAccent = Color(0xFFFFB74D);

  // Legacy aliases so existing code keeps compiling
  static Color get whiteColor => white;
  static Color get blackColor => black;
  static Color get greyColor => grey;
}
