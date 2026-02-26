import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/finalize_screen/finalize_screen.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../questionaire_screens/questionaire_screen_1.dart';

class EmpathyScreen extends StatelessWidget {
  const EmpathyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image
          Image.asset(AppImages.empathyBg, fit: BoxFit.cover),

          // 2. Main Content
          SafeArea(
            top: false,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(flex: 7),

                  // Large Olive Green Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 40.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A6A3A), // Olive Green
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 40.sp,
                              color: AppColors.white,
                              height: 1.1,
                            ),
                            children: const [
                              TextSpan(text: AppStrings.empathyTitle1),
                              TextSpan(
                                text: AppStrings.empathyTitleItalic,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextSpan(text: AppStrings.empathyTitle2),
                            ],
                          ),
                        ),
                        64.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.empathyText,
                                style: TextStyle(
                                  fontFamily: AppFonts.lato,
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(
                                  AppImages.empathyCard,
                                  fit: BoxFit.cover,
                                  height: 100.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuestionaireScreen1(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        AppStrings.nextButton,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
