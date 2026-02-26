import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/utils/widgets/feature_bottom_navigation.dart';
import '../../view_models/importance_view_model.dart';

class ImportanceScreen extends StatelessWidget {
  const ImportanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              //

              // Content overlay
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      48.verticalSpace,

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

                      40.verticalSpace,

                      // "MySkin helps you take control."
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: data.mySkinText,
                              style: TextStyle(
                                fontFamily: AppFonts.playfairDisplay,
                                fontSize: 40.sp,
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
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400,
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            height: 1.5,
                          ),
                        ),
                      ),

                      24.verticalSpace,

                      // Back & Next buttons
                      FeatureBottomNavigation(
                        onNextPressed: () {
                          // TODO: Navigate to next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IntroductionScreen(),
                            ),
                          );
                        },
                        backButtonText: data.backButton,
                        backButtonBorderColor: AppColors.white,
                        backButtonBorderWidth: 1.5.w,
                        backButtonColor: AppColors.white,
                        nextButtonText: data.nextButton,
                        nextButtonBackgroundColor: AppColors.black,
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
