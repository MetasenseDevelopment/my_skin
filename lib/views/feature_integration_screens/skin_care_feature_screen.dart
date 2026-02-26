import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/feature_integration_screens/graph_screen.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_strings.dart';
import 'dart:math' as math;
import 'dart:async';
import 'dart:ui' as ui;
import '../../core/utils/widgets/feature_bottom_navigation.dart';

class SkinCareFeatureScreen extends StatefulWidget {
  const SkinCareFeatureScreen({super.key});

  @override
  State<SkinCareFeatureScreen> createState() => _SkinCareFeatureScreenState();
}

class _SkinCareFeatureScreenState extends State<SkinCareFeatureScreen>
    with TickerProviderStateMixin {
  late AnimationController _cardEntranceController;
  late Animation<Offset> _rightCardOffset;
  late Animation<Offset> _leftCardOffset;
  late Animation<Offset> _centerCardOffset;
  late Animation<double> _centerCardOpacity;

  // Checklist Animation State
  int _checklistPhase =
      0; // 0: Start, 1: Top checked + Bottom missed, 2: Both checked
  Timer? _sequenceTimer;

  // Animation controllers for checklist items
  late AnimationController _topItemController;
  late AnimationController _bottomItemController;

  @override
  void initState() {
    super.initState();
    _cardEntranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _topItemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _bottomItemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Right card comes from right
    _rightCardOffset =
        Tween<Offset>(
          begin: const Offset(1.5, 0.0), // Offscreen right
          end: const Offset(0.15, -0.05), // Final position relative to center
        ).animate(
          CurvedAnimation(
            parent: _cardEntranceController,
            curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    // Left card comes from left
    _leftCardOffset =
        Tween<Offset>(
          begin: const Offset(-1.5, 0.0), // Offscreen left
          end: const Offset(-0.15, 0.05), // Final position relative to center
        ).animate(
          CurvedAnimation(
            parent: _cardEntranceController,
            curve: const Interval(0.2, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    // Center card comes from bottom fast
    _centerCardOffset =
        Tween<Offset>(
          begin: const Offset(0.0, 0.8), // Offscreen bottom
          end: const Offset(0.0, 0.1), // Final position relative to center
        ).animate(
          CurvedAnimation(
            parent: _cardEntranceController,
            curve: const Interval(0.5, 0.95, curve: Curves.easeOutCubic),
          ),
        );

    _centerCardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardEntranceController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _cardEntranceController.forward().then((_) {
      _startChecklistSequence();
    });
  }

  void _startChecklistSequence() {
    // Phase 0 -> Phase 1 -> Phase 2 -> loop
    _sequenceTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        _checklistPhase = (_checklistPhase + 1) % 3;

        if (_checklistPhase == 0) {
          _topItemController.reverse();
          _bottomItemController.reverse();
        } else if (_checklistPhase == 1) {
          _topItemController.forward();
          _bottomItemController.reverse(); // Bottom shows "Missed" in Phase 1
        } else if (_checklistPhase == 2) {
          _topItemController.forward();
          _bottomItemController.forward(); // Bottom becomes checked in Phase 2
        }
      });
    });
  }

  @override
  void dispose() {
    _sequenceTimer?.cancel();
    _cardEntranceController.dispose();
    _topItemController.dispose();
    _bottomItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background top half
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.534.sh,
            child: Container(
              color: const Color(0xFF6B7132), // Olive Green
            ),
          ),

          // Main Layout
          Column(
            children: [
              // Cards Area
              SizedBox(
                height: 0.55.sh,
                child: AnimatedBuilder(
                  animation: _cardEntranceController,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Right Card (Afternoon Routine)
                        SlideTransition(
                          position: _rightCardOffset,
                          child: Transform.rotate(
                            angle: 12 * math.pi / 180, // Rotate ~12 deg
                            child: _buildRoutineCard(
                              title: AppStrings.routineAfternoon,
                              isBackground: true,
                              isChecked:
                                  false, // Afternoon card has unchecked state
                            ),
                          ),
                        ),

                        // Left Card (Evening Routine)
                        SlideTransition(
                          position: _leftCardOffset,
                          child: Transform.rotate(
                            angle: -10 * math.pi / 180, // Rotate ~-10 deg
                            child: _buildRoutineCard(
                              title: AppStrings.routineEvening,
                              isBackground: true,
                              isChecked:
                                  false, // Evening card has checked state
                            ),
                          ),
                        ),

                        // Center Card (Morning Routine)
                        SlideTransition(
                          position: _centerCardOffset,
                          child: Opacity(
                            opacity: _centerCardOpacity.value,
                            child: Transform.rotate(
                              angle: 3 * math.pi / 180, // Very slight rotation
                              child: _buildMainMorningCard(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const Spacer(),

              // Bottom Text & Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 40.sp,
                          color: AppColors.black87,
                          height: 1.1,
                        ),
                        children: [
                          const TextSpan(text: AppStrings.skinCareTitle1),
                          TextSpan(
                            text: AppStrings.skinCareTitle2,
                            style: const TextStyle(
                              color: AppColors.yellowColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const TextSpan(text: AppStrings.skinCareTitle3),
                        ],
                      ),
                    ),

                    32.verticalSpace,

                    // Description
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 18.sp,
                          color: AppColors.darkGrey,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.skinCareDesc1,
                            style: const TextStyle(
                              color: AppColors.yellowColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: AppStrings.skinCareDesc2,
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),

                    40.verticalSpace,

                    // Bottom Buttons
                    FeatureBottomNavigation(
                      onNextPressed: () {
                        // Next Action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GraphScreen(),
                          ),
                        );
                      },
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A simplified card for backgrounds
  Widget _buildRoutineCard({
    required String title,
    required bool isBackground,
    bool isChecked = false,
  }) {
    return Container(
      width: 320.w,
      height: 380.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.yellowColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: AppFonts.playfairDisplay,
              fontSize: 24.sp,
              color: AppColors.black87,
            ),
          ),
          24.verticalSpace,
          // Placeholder for background items
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? AppColors.darkGreen : AppColors.white,
                  border: Border.all(
                    color: isChecked ? AppColors.darkGreen : AppColors.grey,
                    width: 1.w,
                  ),
                ),
                child: isChecked
                    ? Icon(Icons.check, color: AppColors.white, size: 16.w)
                    : null,
              ),
              12.horizontalSpace,
              // Faked text content for background cards
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Text(
                          'CLEANSER',
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w800,
                            color: isChecked
                                ? AppColors.hintGrey
                                : AppColors.darkGrey,
                            letterSpacing: 2,
                          ),
                        ),
                        if (isChecked)
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 1.h,
                                width: 60.w,
                                color: AppColors.hintGrey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    6.verticalSpace,
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Text(
                          'Gentle Foaming Cleanser',
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: isChecked
                                ? AppColors.hintGrey
                                : AppColors.sectionTitleBrown,
                          ),
                        ),
                        if (isChecked)
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 1.h,
                                width: 140.w,
                                color: AppColors.hintGrey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainMorningCard() {
    return Container(
      width: 360.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.yellowColor, width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.routineMorning,
            style: TextStyle(
              fontFamily: AppFonts.playfairDisplay,
              fontSize: 26.sp,
              color: AppColors.black87,
            ),
          ),
          30.verticalSpace,

          // Item 1 (Top)
          _buildAnimatedRoutineItem(
            controller: _topItemController,
            label: AppStrings.supplementsLabel,
            product: AppStrings.vitaminCProduct,
            time: AppStrings.vitaminCTime,
            instruction: AppStrings.vitaminCInstruction,
            description: AppStrings.vitaminCDesc,
            isMissedState: false, // Top item is never in missed state
          ),

          24.verticalSpace,
          Divider(color: AppColors.lightGrey, thickness: 1.w),
          16.verticalSpace,

          // Item 2 (Bottom)
          _buildAnimatedRoutineItem(
            controller: _bottomItemController,
            label: AppStrings.moisturizeLabel,
            product: AppStrings.nightCreamProduct,
            time: AppStrings.nightCreamTime,
            instruction: AppStrings.nightCreamInstruction,
            description: AppStrings.nightCreamDesc,
            isMissedState:
                _checklistPhase == 1, // Bottom item is "missed" in phase 1
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedRoutineItem({
    required AnimationController controller,
    required String label,
    required String product,
    required String time,
    required String instruction,
    required String description,
    required bool isMissedState,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double progress = controller.value;
        final bool isChecked = progress > 0.5;

        // Colors
        final Color instructionColor = isChecked
            ? AppColors.hintGrey
            : AppColors.black;
        final Color productTimeColor = isChecked
            ? AppColors.hintGrey
            : AppColors.black87;
        final Color labelColor = isChecked
            ? AppColors.hintGrey
            : AppColors.darkGrey;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isChecked ? AppColors.darkGreen : AppColors.white,
                      border: Border.all(
                        color: isChecked
                            ? AppColors.darkGreen
                            : AppColors.darkGrey,
                        width: 1.w,
                      ),
                    ),
                    child: isChecked
                        ? Icon(Icons.check, color: AppColors.white, size: 16.w)
                        : null,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: labelColor,
                          letterSpacing: 2,
                        ),
                      ),
                      6.verticalSpace,
                      _buildStrikethroughText(
                        text: product,
                        progress: progress,
                        baseStyle: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: isChecked
                              ? AppColors.hintGrey
                              : AppColors.sectionTitleBrown,
                        ),
                      ),
                      4.verticalSpace,
                      _buildStrikethroughText(
                        text: time,
                        progress: progress,
                        baseStyle: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: productTimeColor,
                        ),
                      ),
                      8.verticalSpace,
                      _buildStrikethroughText(
                        text: instruction,
                        progress: progress,
                        baseStyle: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: instructionColor,
                          height: 1.3,
                        ),
                      ),
                      6.verticalSpace,
                      _buildStrikethroughText(
                        text: description,
                        progress: progress,
                        baseStyle: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintGrey, // Always grey
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Missed State Area (Only shown if isMissedState is true)
            AnimatedCrossFade(
              crossFadeState: isMissedState
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstChild: Padding(
                padding: EdgeInsets.only(top: 12.h, left: 40.w),
                child: Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: const BoxDecoration(
                        color: AppColors.reportRed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      AppStrings.missedStep,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 12.sp,
                        color: AppColors.sectionTitleBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  // Helper widget to draw strikethrough line based on animation progress
  // And change text color smoothly
  Widget _buildStrikethroughText({
    required String text,
    required double progress,
    required TextStyle baseStyle,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Measure text size to draw the line accurately
        final textSpan = TextSpan(text: text, style: baseStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: 2, // Assuming mostly 1 or 2 lines
        )..layout(maxWidth: constraints.maxWidth);

        return Stack(
          children: [
            Text(text, style: baseStyle),
            if (progress > 0)
              Positioned.fill(
                child: CustomPaint(
                  painter: _StrikethroughPainter(
                    progress: progress,
                    textMetrics: textPainter.computeLineMetrics(),
                    color: AppColors
                        .black, // Strikethrough is dark even when text fades
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _StrikethroughPainter extends CustomPainter {
  final double progress;
  final List<ui.LineMetrics> textMetrics;
  final Color color;

  _StrikethroughPainter({
    required this.progress,
    required this.textMetrics,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || textMetrics.isEmpty) return;

    final paint = Paint()
      ..color = color
          .withValues(
            alpha: math.min(1.0, progress * 1.5),
          ) // Fade in slightly faster
      ..strokeWidth = 1.0;

    double currentY = 0;

    // Total width of all lines
    double totalWidth = textMetrics.fold(
      0.0,
      (sum, metrics) => sum + (metrics.width),
    );

    // How much of the total line length to draw based on progress
    double targetLength = totalWidth * progress;
    double drawnLength = 0;

    for (var lineMetrics in textMetrics) {
      if (drawnLength >= targetLength) break;

      double lineY =
          currentY + lineMetrics.height / 2 + 1; // Center of line roughly
      double lineLength = lineMetrics.width;

      double drawLengthForThisLine = math.min(
        lineLength,
        targetLength - drawnLength,
      );

      canvas.drawLine(
        Offset(0, lineY),
        Offset(drawLengthForThisLine, lineY),
        paint,
      );

      drawnLength += lineLength;
      currentY += lineMetrics.height;
    }
  }

  @override
  bool shouldRepaint(covariant _StrikethroughPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
