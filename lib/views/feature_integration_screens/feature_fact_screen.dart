import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_strings.dart';
import 'jcd_feature_screen.dart';
import '../../core/utils/widgets/feature_bottom_navigation.dart';

class FeatureFactScreen extends StatelessWidget {
  const FeatureFactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Top Red Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.5.sh,
            child: Container(
              color: AppColors.darkRed, // or a darker red if needed
              child: Stack(
                children: [
                  Positioned(
                    top: 20.h,
                    right: -180.w,
                    child: Text(
                      'FACT',
                      style: TextStyle(
                        fontFamily: AppFonts.playfairDisplay,
                        fontSize: 316.sp,
                        color: AppColors.yellowColor.withValues(alpha: 0.15),
                        height: 1,
                        letterSpacing: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                180.verticalSpace,

                // Central Card
                Center(
                  child: Container(
                    width: 335.w,
                    padding: EdgeInsets.only(left: 26.w, right: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.black, width: 1.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            AppStrings.factTitle,
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 60.sp,
                              color: AppColors.yellowColor,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        40.verticalSpace,
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 36.sp,
                              color: AppColors.black87,
                              height: 1.2,
                              letterSpacing: 0.5,
                            ),
                            children: [
                              TextSpan(text: AppStrings.factDescription1),
                              TextSpan(
                                text: AppStrings.factDescription2,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),

                37.5.verticalSpace,

                // Footer text below card, right aligned
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 54.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 18.sp,
                          color: AppColors.darkGrey,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(text: AppStrings.factFooter1),
                          TextSpan(
                            text: AppStrings.factFooter2,
                            style: TextStyle(
                              color: AppColors.yellowColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: AppStrings.factFooter3),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Bottom Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: FeatureBottomNavigation(
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JcdFeatureScreen(),
                        ),
                      );
                    },
                  ),
                ),
                24.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
