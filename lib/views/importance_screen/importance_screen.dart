import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../view_models/importance_view_model.dart';

class ImportanceScreen extends StatelessWidget {
  const ImportanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ImportanceViewModel>(
        builder: (context, viewModel, child) {
          final data = viewModel.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Full-screen background image
              Image.asset(
                AppImages.importance,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              // Gradient overlay for bottom readability
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 280.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.0),
                        Colors.black.withValues(alpha: 0.6),
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // Content overlay
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.verticalSpace,

                      // Main title
                      Text(
                        data.title,
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: AppColors.white,
                          height: 1.15,
                        ),
                      ),

                      24.verticalSpace,

                      // "MySkin helps you take control."
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: data.mySkinText,
                              style: TextStyle(
                                fontFamily: AppFonts.playfairDisplay,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: AppColors.white,
                                height: 1.15,
                              ),
                            ),
                            TextSpan(
                              text: data.subtitle,
                              style: TextStyle(
                                fontFamily: AppFonts.playfairDisplay,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: AppColors.white,
                                height: 1.15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Footer text — right aligned
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          data.footer,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: AppFonts.playfairDisplay,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            height: 1.5,
                          ),
                        ),
                      ),

                      24.verticalSpace,

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
                                    width: 1.5.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  data.backButton,
                                  style: TextStyle(
                                    fontSize: 18.sp,
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
                                  // TODO: Navigate to next screen
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  foregroundColor: AppColors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  data.nextButton,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
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
