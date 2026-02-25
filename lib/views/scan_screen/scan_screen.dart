import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_icons.dart';
import '../../view_models/scan_view_model.dart';
import 'widgets/scan_slider_button.dart';
import 'widgets/animated_camera_image.dart';
import '../camera_screen/camera_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black87,
      body: SafeArea(
        top: false,
        child: Consumer<ScanViewModel>(
          builder: (context, viewModel, child) {
            final data = viewModel.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  125.verticalSpace,

                  // Animated Camera Image
                  const AnimatedCameraImage(),

                  Spacer(),

                  // Subtitle
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      fontFamily: AppFonts.lato,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.yellowColor,
                      letterSpacing: 1.2,
                    ),
                  ),

                  16.verticalSpace,

                  // Main Title
                  Text(
                    data.title,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 44.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                      height: 1.15,
                    ),
                  ),

                  32.verticalSpace,

                  // Bullet point 1: Time
                  Row(
                    children: [
                      Iconify(
                        AppIcons.clock,
                        color: AppColors.yellowColor,
                        size: 20.sp,
                      ),
                      12.horizontalSpace,
                      Text(
                        data.bullet1,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintGrey,
                        ),
                      ),
                    ],
                  ),

                  16.verticalSpace,

                  // Bullet point 2: Lighting
                  Row(
                    children: [
                      Iconify(
                        AppIcons.sun,
                        color: AppColors.yellowColor,
                        size: 20.sp,
                      ),
                      12.horizontalSpace,
                      Text(
                        data.bullet2,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintGrey,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Slide to Scan Button
                  ScanSliderButton(
                    text: data.slideText,
                    onSlideComplete: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraScreen(),
                        ),
                      );
                    },
                  ),

                  20.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
