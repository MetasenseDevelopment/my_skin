import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_strings.dart';

class SplashTitleSection extends StatelessWidget {
  const SplashTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.playfairDisplay,
          height: 1.15,
        ),
        children: [
          TextSpan(
            text: AppStrings.splashYour,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              height: 1.2,
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: AppStrings.splashSkinJourney,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: AppColors.goldColor,
              height: 1.2,
            ),
          ),
          // ── "begins here." ────────────────────────────────────────
          TextSpan(
            text: AppStrings.splashBeginsHere,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: AppColors.black,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
