// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_strings.dart';

class EmailSignupButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final bool? isActive;
  final double? width;
  final String? label;

  const EmailSignupButtonWidget({
    super.key,
    required this.isLoading,
    required this.onTap,
    this.isActive,
    this.width,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isActive ?? true;
    final Color innerColor = active
        ? AppColors.accentYellow
        : const Color(0xFFF6F6F6);
    final Color textColor = active ? AppColors.white : Colors.black38;

    // ── Shared inner content ───────────────────────────────────────────
    final Widget innerContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: innerColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                label ?? AppStrings.signUpWithEmail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: AppFonts.lato,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );

    // ── Inactive: no outer shadow container ───────────────────────────
    if (!active) {
      return GestureDetector(
        onTap: null,
        child: SizedBox(
          width: width ?? 303.w,
          height: 65.h,
          child: innerContent,
        ),
      );
    }

    // ── Active: full outer container with shadows ─────────────────────
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? 303.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -1),
              blurRadius: 8,
              color: AppColors.black.withOpacity(0.04),
            ),
            BoxShadow(
              offset: const Offset(-4, 12),
              blurRadius: 20,
              spreadRadius: 6,
              color: AppColors.accentYellow.withOpacity(0.20),
            ),
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 10,
              color: AppColors.accentYellow.withOpacity(0.4),
            ),
          ],
        ),
        child: innerContent,
      ),
    );
  }
}
