import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/feature_integration_screens/feature_fact_screen.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../../core/utils/widgets/feature_bottom_navigation.dart';

class FeatureAuditScreen extends StatelessWidget {
  const FeatureAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Background Image
          Image.asset(AppImages.auditBg, fit: BoxFit.cover),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: Column(
              children: [
                61.verticalSpace,
                Container(
                  padding: EdgeInsets.all(25.h),
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
                                  fontSize: 38.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.yellowColor,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              6.verticalSpace,
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
                                  fontSize: 38.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black87,
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
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.black,
                                letterSpacing: 2.5,
                                height: 1.3,
                              ),
                            ),
                            35.verticalSpace,
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
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 20.h,
                          right: 62.w,
                          bottom: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              AppColors.lightGrey2, // a light grey like #F2F2F2
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: AppFonts.lato,
                              fontSize: 16.sp,
                              color: AppColors.black87,
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
                52.verticalSpace,
                // Bottom Asterisk Text
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.auditReportDisclaimer,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 18.sp,
                      color: AppColors.white,
                      height: 1.4,
                    ),
                  ),
                ),
                73.verticalSpace,
                // Bottom Button
                FeatureBottomNavigation(
                  onNextPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeatureFactScreen(),
                      ),
                    );
                  },
                ),
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
              width: 8.w,
              height: 8.w,
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
                  fontSize: 14.sp,
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
              fontSize: 18.sp,
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
