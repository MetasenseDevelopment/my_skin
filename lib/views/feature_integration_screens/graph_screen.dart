import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../../core/utils/widgets/feature_bottom_navigation.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _lineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation with a slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1E1E1E,
      ), // Dark grey background from design
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                40.verticalSpace,
                // Top Text Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.graphScreenTitle,
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 84.sp,
                          color: AppColors.yellowColor,
                          height: 1.0,
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppStrings.graphScreenSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 24.sp,
                          color: AppColors.white,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Graph Area
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow Effect Behind Rose
                      Positioned(
                        bottom: 0.14.sh,
                        child: Container(
                          width: 250.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withValues(alpha: 0.8),
                                blurRadius: 100,
                                spreadRadius: 30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Rose Image
                      Positioned(
                        bottom: 120.h,
                        child: Image.asset(
                          AppImages.roseLogo,
                          width: 280.w,
                          height: 285.h,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Animated Arc
                      Positioned(
                        bottom: 130.h,
                        child: SizedBox(
                          width: 280.w,
                          height: 280.w,
                          child: AnimatedBuilder(
                            animation: _lineAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: _ArcPainter(
                                  progress: _lineAnimation.value,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer pushing the graph area up, ensuring it is half-covered by the liquid glass
                SizedBox(height: 150.h),
              ],
            ),
          ),

          // Glassy Bottom Container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LiquidGlass.withOwnLayer(
              shape: const LiquidRoundedRectangle(borderRadius: 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  24.w,
                  40.h,
                  24.w,
                  MediaQuery.of(context).padding.bottom + 24.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Numbers\n',
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 40.sp,
                              color: AppColors.yellowColor,
                              fontStyle: FontStyle.italic,
                              height: 1.1,
                            ),
                          ),
                          TextSpan(
                            text: 'don\'t lie.',
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 40.sp,
                              color: AppColors.white,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 14.sp,
                          color: AppColors.grey,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(
                            text:
                                'Our internal 12-week observational study\nobserved a 300% improvement in skin\nbarrier resilience and hydration among\nusers who consistently followed ',
                          ),
                          TextSpan(
                            text: 'MySkin',
                            style: TextStyle(
                              color: AppColors.yellowColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: '\nrituals.'),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    FeatureBottomNavigation(
                      onNextPressed: () {
                        // TODO: Navigate to next page
                      },
                      backButtonBorderColor: AppColors.white,
                      backButtonColor: AppColors.white,
                      nextButtonBackgroundColor: AppColors.yellowColor,
                      nextButtonTextColor: AppColors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // The arc background glow
    final glowPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // The solid arc line
    final linePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.w
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Start angle at 180 degrees (left side), sweep up and over to ~45 degrees (right side)
    const startAngle = math.pi; // Left side
    const totalSweepAngle = math.pi * 0.8; // 80% of a half circle
    final currentSweepAngle = totalSweepAngle * progress;

    // Draw arc glow
    canvas.drawArc(rect, startAngle, currentSweepAngle, false, glowPaint);
    // Draw arc line
    canvas.drawArc(rect, startAngle, currentSweepAngle, false, linePaint);

    // Draw the yellow circle at the end of the arc
    if (progress > 0.1) {
      // Only draw circle after arc has started moving
      final circlePaint = Paint()
        ..color = AppColors.yellowColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.w;

      // Calculate the position of the end of the arc
      final endAngle = startAngle + currentSweepAngle;
      final circleCenter = Offset(
        center.dx + radius * math.cos(endAngle),
        center.dy + radius * math.sin(endAngle),
      );

      // Draw the yellow circle outline
      canvas.drawCircle(circleCenter, 6.w, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
