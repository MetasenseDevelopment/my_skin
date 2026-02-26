// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  final double? width; // optional width

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? 303.w, // if null → default width
        height: 54.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.lightGrey, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: AppFonts.lato,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
