import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/consts/app_colors.dart';

class AnalysisLoadingDots extends StatefulWidget {
  const AnalysisLoadingDots({super.key});

  @override
  State<AnalysisLoadingDots> createState() => _AnalysisLoadingDotsState();
}

class _AnalysisLoadingDotsState extends State<AnalysisLoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int dotCount = 8;
    final double radius = 16.w;

    // Dot sizes that vary from large to small around the circle
    final List<double> dotSizes = [7.w, 6.w, 5.w, 4.w, 3.5.w, 3.w, 4.w, 5.5.w];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: radius * 2 + 10.w,
          height: radius * 2 + 10.w,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(dotCount, (index) {
              // Rotate the entire arrangement based on the animation
              final double angle =
                  (2 * pi / dotCount) * index + (_controller.value * 2 * pi);
              final double x = radius * cos(angle);
              final double y = radius * sin(angle);
              final double size = dotSizes[index % dotSizes.length];

              return Transform.translate(
                offset: Offset(x, y),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellowColor,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
