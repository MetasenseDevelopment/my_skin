// ── Footer privacy text ───────────────────────────────────────────────────────
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: AppFonts.lato,
          color: AppColors.darkGrey,
          letterSpacing: .02,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        children: [
          const TextSpan(
            text: "By signing up or continuing, you agree to our\n",
          ),
          TextSpan(
            text: " Privacy Policy",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.yellowColor,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: " and "),
          TextSpan(
            text: "Terms & Conditions",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.yellowColor,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
