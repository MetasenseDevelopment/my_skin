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

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gold, goldBottom],
  );

  // Shadows
  static Color goldShadow = gold.withValues(alpha: 0.4);
  static Color blackShadow = Colors.black.withValues(alpha: 0.1);
}
