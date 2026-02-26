import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_images.dart';

class MySkinLogo extends StatelessWidget {
  final bool lightBackground;
  const MySkinLogo({super.key, required this.lightBackground});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.roseLogo, width: 58.8.w, height: 59.53.h),
        SizedBox(height: 8.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'My',
                style: TextStyle(
                  fontFamily: AppFonts.playfairDisplay,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.goldColor,
                ),
              ),
              TextSpan(
                text: 'Skin',
                style: TextStyle(
                  fontFamily: AppFonts.playfairDisplay,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: lightBackground ? Colors.black87 : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
