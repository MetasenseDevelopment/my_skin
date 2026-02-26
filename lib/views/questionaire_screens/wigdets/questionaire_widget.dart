import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/consts/app_colors.dart';
import '../../../core/consts/app_fonts.dart';

class QuestionaireWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String question;
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onOptionSelected;
  final VoidCallback onNext;
  final Color tiltColor;
  final double tiltAngle;

  const QuestionaireWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
    required this.onNext,
    required this.tiltColor,
    required this.tiltAngle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  Spacer(),

                  // The Cards
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Back tilted card
                      Padding(
                        padding: tiltAngle < 0
                            ? EdgeInsets.only(bottom: 20.h, right: 10.w)
                            : EdgeInsets.only(bottom: 20.h, left: 10.w),
                        child: Transform.rotate(
                          angle: tiltAngle,
                          child: Container(
                            width: double.infinity,
                            height: 410.h,
                            decoration: BoxDecoration(
                              color: tiltColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ),
                      ),

                      // Front Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 32.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: tiltColor, width: 2.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackShadow,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontFamily: AppFonts.lato,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.yellowColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            12.verticalSpace,
                            Text(
                              question,
                              style: TextStyle(
                                fontFamily: AppFonts.playfairDisplay,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                height: 1.2,
                              ),
                            ),
                            20.verticalSpace,
                            Divider(
                              color: AppColors.yellowColor.withValues(
                                alpha: 0.5,
                              ),
                              thickness: 1,
                            ),
                            20.verticalSpace,

                            // Options
                            ...List.generate(options.length, (index) {
                              final isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () => onOptionSelected(index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  child: Row(
                                    children: [
                                      // Radio circle
                                      Container(
                                        width: 24.w,
                                        height: 24.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.black
                                                : AppColors.grey,
                                            width: isSelected ? 0 : 2.w,
                                          ),
                                          color: isSelected
                                              ? AppColors.black
                                              : Colors.transparent,
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.check,
                                                color: AppColors.white,
                                                size: 16.w,
                                              )
                                            : null,
                                      ),
                                      12.horizontalSpace,
                                      Text(
                                        options[index],
                                        style: TextStyle(
                                          fontFamily: AppFonts.lato,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected
                                              ? AppColors.black
                                              : AppColors.darkGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Bottom Buttons
                  Row(
                    children: [
                      // Back button
                      Expanded(
                        child: SizedBox(
                          height: 54.h,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.15,
                              ),
                              side: BorderSide(
                                color: AppColors.white,
                                width: 1.w,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Back',
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
                            onPressed: onNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.black87,
                              foregroundColor: AppColors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Next',
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
      ),
    );
  }
}
