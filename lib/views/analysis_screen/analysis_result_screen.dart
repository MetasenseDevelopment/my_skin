import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import 'analysis_full_report_screen.dart';
import '../../core/utils/widgets/glassy_app_bar.dart';

class AnalysisResultScreen extends StatelessWidget {
  const AnalysisResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassyAppBar(),
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
                width: 320.w,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Side blurred roses decoration (optional, mimicking reference)
          Positioned(
            top: 400.h,
            right: -40.w,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(AppImages.roseLogo, width: 100.w),
            ),
          ),
          Positioned(
            top: 500.h,
            left: -40.w,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(AppImages.roseLogo, width: 80.w),
            ),
          ),

          // 2. Main Content
          SafeArea(
        top: false,
        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Spacer(flex: 4),

                  // "ESTIMATED SKIN AGE"
                  Text(
                    AppStrings.estimatedSkinAge,
                    style: TextStyle(
                      fontFamily: AppFonts.lato,
                      fontSize: 14.sp,
                      color: AppColors.hintGrey,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  16.verticalSpace,

                  // "24 years"
                  Text(
                    AppStrings.ageValue,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 100.sp,
                      color: AppColors.black,
                      height: 1.0,
                    ),
                  ),
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
                      color: const Color(0xFFE8F5E9), // Light green bg
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Text(
                      AppStrings.ageComparison,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 12.sp,
                        color: const Color(0xFF2E7D32), // Darker green text
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
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColors.hintGrey.withValues(alpha: 0.2),
                        width: 1,
                      ),
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
                            fontSize: 14.sp,
                            color: AppColors.black,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        20.verticalSpace,
                        Text(
                          AppStrings.analysisSummaryText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16.sp,
                            color: AppColors.hintGrey,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(flex: 1),

                  // "View Full Report" Bottom Button
                  SizedBox(
                    width: double.infinity,
                    height: 64.h,
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
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withValues(alpha: 0.3),
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
