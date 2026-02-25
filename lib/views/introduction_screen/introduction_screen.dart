import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/scan_screen/scan_screen.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../view_models/introduction_view_model.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<IntroductionViewModel>(
        builder: (context, viewModel, child) {
          final data = viewModel.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Full-screen background image
              Image.asset(
                AppImages.introductionImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              // Content overlay
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Spacer at the top (optional, depending on safe area)
                      76.verticalSpace,

                      // Glassy Container
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 40.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Main title
                                  Text(
                                    data.title,
                                    style: TextStyle(
                                      fontFamily: AppFonts.playfairDisplay,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                      height: 1.15,
                                    ),
                                  ),

                                  Spacer(flex: 2),

                                  // Inner Image
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        AppImages.introSmallImage,
                                        width: double.infinity,
                                        height: 231.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  Spacer(flex: 2),

                                  // Subtitle
                                  Text(
                                    data.subtitle,
                                    style: TextStyle(
                                      fontFamily: AppFonts.lato,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                      height: 1.2,
                                    ),
                                  ),

                                  16.verticalSpace,

                                  // Description
                                  Text(
                                    data.description,
                                    style: TextStyle(
                                      fontFamily: AppFonts.lato,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      32.verticalSpace,

                      // Back & Next buttons
                      Row(
                        children: [
                          // Back button
                          Expanded(
                            child: SizedBox(
                              height: 54.h,
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: AppColors.white,
                                    width: 1.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Back', // Hardcoded back to simplify model
                                  style: TextStyle(
                                    fontFamily: AppFonts.lato,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          16.horizontalSpace,

                          // Next button
                          Expanded(
                            child: SizedBox(
                              height: 54.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScanScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.black,
                                  foregroundColor: AppColors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  data.nextButton,
                                  style: TextStyle(
                                    fontFamily: AppFonts.lato,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
