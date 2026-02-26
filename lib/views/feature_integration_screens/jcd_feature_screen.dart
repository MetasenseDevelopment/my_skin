import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import 'skin_care_feature_screen.dart';
import '../../core/utils/widgets/feature_bottom_navigation.dart';

class JcdFeatureScreen extends StatelessWidget {
  const JcdFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Top Background Image
          SizedBox(
            width: double.infinity,
            height:
                0.422.sh, // Assuming it takes a bit less than half the screen
            child: Image.asset(AppImages.jcdFeatureBg, fit: BoxFit.cover),
          ),

          // Bottom Content
          Expanded(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.verticalSpace,

                    // Journal Header
                    Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF161B40), // Dark blue
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.accentYellow,
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'JCD',
                              style: TextStyle(
                                fontFamily: AppFonts.lato,
                                fontSize: 14.4.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          AppStrings.jcdJournal,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),

                    26.verticalSpace,

                    // Title
                    Text(
                      AppStrings.jcdTitle,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                        height: 1.3,
                      ),
                    ),

                    21.verticalSpace,

                    // Description
                    Text(
                      AppStrings.jcdDescription,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                        height: 1.5,
                      ),
                    ),

                    20.verticalSpace,

                    // Author
                    Text(
                      AppStrings.jcdAuthor,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Spacer(),

                    // Bottom Buttons
                    FeatureBottomNavigation(
                      onNextPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SkinCareFeatureScreen(),
                          ),
                        );
                      },
                    ),
                    24.verticalSpace, // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
