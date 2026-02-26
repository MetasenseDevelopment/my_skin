import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/consts/app_colors.dart';

class NextButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback onPressed;

  // Optional text styling
  final double? fontSize;
  final double? letterSpacing;
  final double? textHeight;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const NextButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.onPressed,
    this.fontSize,
    this.letterSpacing,
    this.textHeight,
    this.fontFamily,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.black : AppColors.disabledGrey,
          disabledBackgroundColor: AppColors.disabledGrey,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.disabledTextGrey,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize?.sp ?? 18.sp, // default 18.sp
            fontWeight: fontWeight ?? FontWeight.bold,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            height: textHeight,
          ),
        ),
      ),
    );
  }
}
