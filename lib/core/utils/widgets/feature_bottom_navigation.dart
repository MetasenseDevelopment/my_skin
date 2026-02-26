import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_fonts.dart';
import '../../consts/app_strings.dart';

class FeatureBottomNavigation extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final String nextButtonText;
  final String backButtonText;
  final Color? backButtonColor;
  final Color? backButtonBorderColor;
  final Color? backButtonBackgroundColor;
  final double? backButtonBorderWidth;
  final Color? nextButtonBackgroundColor;
  final Color? nextButtonTextColor;

  const FeatureBottomNavigation({
    super.key,
    this.onBackPressed,
    this.onNextPressed,
    this.nextButtonText = AppStrings.nextButton,
    this.backButtonText = AppStrings.backButton,
    this.backButtonColor,
    this.backButtonBorderColor,
    this.backButtonBackgroundColor,
    this.backButtonBorderWidth,
    this.nextButtonBackgroundColor,
    this.nextButtonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: OutlinedButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: backButtonColor ?? AppColors.black,
                backgroundColor: backButtonBackgroundColor,
                side: BorderSide(
                  color: backButtonBorderColor ?? AppColors.black,
                  width: backButtonBorderWidth ?? 1.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                backButtonText,
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: backButtonColor ?? AppColors.black,
                ),
              ),
            ),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: SizedBox(
            height: 54.h,
            child: ElevatedButton(
              onPressed: onNextPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: nextButtonBackgroundColor ?? AppColors.black87,
                foregroundColor: nextButtonTextColor ?? AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                nextButtonText,
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: nextButtonTextColor ?? AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
