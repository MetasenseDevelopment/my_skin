// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_images.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/views/finalize_screen/widgets/splash_title_section.dart';
import 'package:my_skin/views/subscription_screen/subscription_screen.dart';
import 'package:my_skin/views/user_info_screen/widgets/next_button.dart';

class FinalizesScreen extends StatelessWidget {
  const FinalizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60.h),
              SplashTitleSection(),
              Spacer(),
              SizedBox(
                width: 197.2.w,
                height: 197.2.h,
                child: Image.asset(AppImages.roseLogo, fit: BoxFit.contain),
              ),
              Spacer(),
              Text(
                AppStrings.finalizeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: AppFonts.lato,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: AppColors.primaryBlack,
                  height: 25 / 20,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                child: NextButton(
                  text: "Next",
                  isEnabled: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
