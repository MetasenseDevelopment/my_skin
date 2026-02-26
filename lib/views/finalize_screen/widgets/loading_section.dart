// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/view_models/splash_view_model.dart';
import 'package:provider/provider.dart';

class LoadingSection extends StatelessWidget {
  const LoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activeDot = context.watch<SplashViewModel>().activeDot;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < 0) {
          context.read<SplashViewModel>().swipeNext();
        } else {
          context.read<SplashViewModel>().swipePrev();
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Dot(active: activeDot == 0),
              const SizedBox(width: 5),
              _Dot(active: activeDot == 1),
              const SizedBox(width: 5),
              _Dot(active: activeDot == 2),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: Text(
              AppStrings.splashLoadingTexts[activeDot],
              key: ValueKey<int>(activeDot),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: AppFonts.lato,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColors.primaryBlack,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active;

  const _Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: active ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.orangeColor : AppColors.lightOrangeColor,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
