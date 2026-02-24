import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color gold = Color(0xFFF3D652);
  static const Color goldBottom = Color(0xFFEACF55);

  // Neutrals
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black87 = Color(0xff1C1C1C);
  static const Color black54 = Colors.black54;
  static const Color darkGrey = Color(0xff6B6B6B);
  static const Color accentYellow = Color(0xFFF3D652);
  static const Color lightGrey = Color(0xFFE8E8E8);
  static const Color hintGrey = Color(0xFFBBBBBB);
  static const Color disabledGrey = Color(0xFFF2F2F2);
  static const Color disabledTextGrey = Color(0xFFCCCCCC);
  static const Color yellowColor = Color(0xFFD3A860);

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gold, goldBottom],
  );

  // Shadows
  static Color goldShadow = gold.withValues(alpha: 0.4);
  static Color blackShadow = Colors.black.withValues(alpha: 0.1);

  // Full Report Colors
  static const Color reportRed = Color(0xFFD32F2F);
  static const Color progressBg = Color(0xFFEEEEEE);
  static const Color progressGreen = Color(0xFF4CAF50);
  static const Color progressRed = Color(0xFFE53935);
  static const Color sectionTitleBrown = Color(0xFFC07C5D);
  static const Color tagMediumBg = Color(0xFFFFF3E0);
  static const Color tagMediumText = Color(0xFFE65100);
  static const Color tagLowBg = Color(0xFFE8F5E9);
  static const Color tagLowText = Color(0xFF2E7D32);
  static const Color quoteBg = Color(0xFFF9F9F9);
}
