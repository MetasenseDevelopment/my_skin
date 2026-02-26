// ── MySkin stylised text ──────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_skin/core/consts/app_images.dart';

class MySkinText extends StatelessWidget {
  const MySkinText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.mySkinLogo,
          width: 180.w,
          height: 180.w,
          fit: BoxFit.contain,
        ),
        //   SizedBox(height: 20.h),
        //   RichText(
        //     text: TextSpan(
        //       children: [
        //         TextSpan(
        //           text: "My",
        //           style: TextStyle(
        //             fontSize: 58.sp,
        //             fontFamily: AppFonts.playfairDisplay,
        //             fontStyle: FontStyle.italic,
        //             fontWeight: FontWeight.w400,
        //             color: Colors.black,
        //             height: 1.0,
        //           ),
        //         ),
        //         TextSpan(
        //           text: "Skin",
        //           style: TextStyle(
        //             fontSize: 58.sp,
        //             fontFamily: AppFonts.playfairDisplay,
        //             fontStyle: FontStyle.normal,
        //             fontWeight: FontWeight.w700,
        //             color: Colors.black,
        //             height: 1.0,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
      ],
    );
  }
}
