import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_images.dart';

class RoseLogo extends StatelessWidget {
  final bool isActive;
  const RoseLogo({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.roseLogo,
      fit: BoxFit.contain,
      width: 146.w,
      height: 148.h,
    );
  }
}
