// ignore_for_file: deprecated_member_use, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/views/auth_screen/welcome_session.dart';
import 'package:my_skin/views/subscription_screen/widget/main_card_widget.dart';
import 'package:my_skin/views/user_info_screen/widgets/next_button.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1EF),
      body: Stack(
        children: [
          // 🔴 RED GRADIENT — top portion only
          Container(
            height: 320.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFCC2222), Color(0xFFAA1A1A)],
              ),
            ),
          ),

          // 🔤 WATERMARK "MY" text — large faded behind content
          Positioned(
            top: 10,
            left: -250,
            child: Text(
              "SUBSCRIPTION",
              style: TextStyle(
                fontSize: 300.sp,
                fontFamily: AppFonts.playfairDisplay,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.07),
                height: 1,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),

                  // 🃏 White card
                  const MainCardWidget(),

                  SizedBox(height: 36.h),

                  // 🔹 Feature bullets
                  _bullet("UNLOCKS ALL FEATURES"),
                  SizedBox(height: 10.h),
                  _bullet("SOME OTHER FEATURE"),

                  SizedBox(height: 48.h),

                  // ℹ️ Renewal notice
                  Text(
                    "RENEWS AUTOMATICALLY  ·  CANCEL ANYTIME",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.sp,
                      letterSpacing: 1.5,
                      fontFamily: AppFonts.lato,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // 🖤 SUBSCRIBE button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: NextButton(
                      text: "SUBSCRIBE",
                      isEnabled: true,
                      letterSpacing: 4,
                      fontFamily: AppFonts.lato,
                      fontSize: 18.sp,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeSession(),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 🔗 Footer links
                  Text(
                    "RESTORE   ·   TERMS   ·   PRIVACY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      letterSpacing: 1.8,
                      fontFamily: AppFonts.lato,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              letterSpacing: 2.0,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.lato,
              color: AppColors.primaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}
