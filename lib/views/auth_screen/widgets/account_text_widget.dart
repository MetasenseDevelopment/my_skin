import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';

class AccountTextWidget extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onTap;

  const AccountTextWidget({
    super.key,
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18.sp,
          fontFamily: AppFonts.lato,
          color: Colors.grey.shade600,
        ),
        children: [
          TextSpan(text: title),
          TextSpan(
            text: actionText,
            style: TextStyle(
              color: AppColors.yellowColor,
              fontWeight: FontWeight.w600,
              fontFamily: AppFonts.lato,
              fontSize: 18.sp,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
