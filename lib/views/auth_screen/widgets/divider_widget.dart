import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: AppColors.secondaryGrey, thickness: 1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "OR",
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: AppFonts.dmSerifDisplay,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: AppColors.secondaryGrey, thickness: 1),
          ),
        ],
      ),
    );
  }
}
