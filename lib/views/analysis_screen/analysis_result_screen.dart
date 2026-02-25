import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import 'analysis_full_report_screen.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. Decorative Rose Header (Top)
          Positioned(
            top: -50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppImages.roseLogo, // Using the existing rose logo
                width: 378.w,
                height: 386.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Side blurred roses decoration (optional, mimicking reference)
          Positioned(
            top: 400.h,
            right: -40.w,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Image.asset(AppImages.roseLogo, width: 95.w, height: 95.h),
            ),
          ),
          Positioned(
            top: 500.h,
            left: -40.w,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Image.asset(AppImages.roseLogo, width: 77.w, height: 77.h),
            ),
          ),

          // 2. Main Content
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  343.verticalSpace,

                  // "ESTIMATED SKIN AGE"
                  Text(
                    AppStrings.estimatedSkinAge,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 18.sp,
                      color: AppColors.darkGrey,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  10.verticalSpace,

                  // "24 years"
                  Text(
                    AppStrings.ageValue,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 100.sp,
                      color: AppColors.black87,
                      height: 1.0,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    AppStrings.ageUnit,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 40.sp,
                      color: AppColors.black,
                      height: 0.8,
                    ),
                  ),

                  32.verticalSpace,

                  // "YOUNGER THAN ACTUAL AGE" Pill
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFDFF3DA), Color(0xFFBDE7B0)],
                      ),
                      borderRadius: BorderRadius.circular(39.r),
                    ),
                    child: Text(
                      AppStrings.ageComparison,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 16.sp,
                        color: AppColors.darkGreen,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Spacer(flex: 2),

                  // "ANALYSIS SUMMARY" Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: AppColors.grey, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.analysisSummaryTitle,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16.sp,
                            color: AppColors.black87,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppStrings.analysisSummaryText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16.sp,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(flex: 1),

                  // "View Full Report" Bottom Button
                  Container(
                    width: double.infinity,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: AppColors.black87,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackShadow.withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AnalysisFullReportScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppStrings.viewFullReport,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 18.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
