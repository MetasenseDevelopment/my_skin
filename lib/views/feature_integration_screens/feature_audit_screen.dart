import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';

class FeatureAuditScreen extends StatelessWidget {
  const FeatureAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Background Image
          Column(
            children: [
              Container(
                height: 329.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff6A6A3A), Color(0xff424214)],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(AppImages.auditBg, fit: BoxFit.fill),
                ),
              ),
            ],
          ),

          SafeArea(
            child: Column(
              children: [
                24.verticalSpace,

                // Main Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 575.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 32.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.auditHeader,
                                  style: TextStyle(
                                    fontFamily: AppFonts.playfairDisplay,
                                    fontSize: 32.sp,
                                    color: AppColors.yellowColor,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  AppStrings.regimenScore,
                                  style: TextStyle(
                                    fontFamily: AppFonts.lato,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.grey,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppStrings.auditPercentage,
                                  style: TextStyle(
                                    fontFamily: AppFonts.playfairDisplay,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  AppStrings.optimized,
                                  style: TextStyle(
                                    fontFamily: AppFonts.lato,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.grey,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        32.verticalSpace,

                        // Body Section with left border
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: AppColors.yellowColor,
                                width: 2.w,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.criticalInefficiencies,
                                style: TextStyle(
                                  fontFamily: AppFonts.lato,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.black,
                                  letterSpacing: 2.5,
                                  height: 1.3,
                                ),
                              ),
                              24.verticalSpace,
                              _buildBulletPoint(
                                title: AppStrings.productMismatch,
                                description: AppStrings.myskinProvides,
                              ),
                              20.verticalSpace,
                              _buildBulletPoint(
                                title: AppStrings.somethingElse,
                                description: AppStrings.myskinProvides,
                              ),
                            ],
                          ),
                        ),

                        32.verticalSpace,

                        // Bottom grey container
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors
                                .disabledGrey, // a light grey like #F2F2F2
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: AppFonts.lato,
                                fontSize: 13.sp,
                                color: AppColors.black,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                              children: const [
                                TextSpan(
                                  text: AppStrings.appTitle,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                TextSpan(text: AppStrings.myskinIdentified),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom Asterisk Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    AppStrings.auditReportDisclaimer,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 16.sp,
                      color: AppColors.white,
                      height: 1.4,
                    ),
                  ),
                ),

                24.verticalSpace,

                // Bottom Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for Next
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black87,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.nextButton,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                16.verticalSpace, // Additional padding for bottom safe area if needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: AppColors.reportRed,
                shape: BoxShape.circle,
              ),
            ),
            8.horizontalSpace,
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 14.sp,
              color: AppColors.darkGrey,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: '${AppStrings.appTitle} ',
                style: TextStyle(
                  color: AppColors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(text: description),
            ],
          ),
        ),
      ],
    );
  }
}
