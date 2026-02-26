import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/feature_integration_screens/feature_audit_screen.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_strings.dart';
import '../../view_models/medics_view_model.dart';

class MedicsScreen extends StatefulWidget {
  const MedicsScreen({super.key});

  @override
  State<MedicsScreen> createState() => _MedicsScreenState();
}

class _MedicsScreenState extends State<MedicsScreen> {
  final TextEditingController _customProductController =
      TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _customProductController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MedicsViewModel(),
      child: Consumer<MedicsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    92.verticalSpace,
                    // Title
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 40.sp,
                          color: AppColors.black,
                          height: 1.1,
                        ),
                        children: const [
                          TextSpan(text: AppStrings.medicsTitle1),
                          TextSpan(
                            text: AppStrings.medicsTitleItalic,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          TextSpan(text: AppStrings.medicsTitle2),
                        ],
                      ),
                    ),
                    28.verticalSpace,
                    // Subtitle
                    Text(
                      AppStrings.medicsSubtitle,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 18.sp,
                        color: AppColors.darkGrey,
                        height: 1.4,
                      ),
                    ),

                    // Products List
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  32.verticalSpace,
                                  Wrap(
                                    spacing: 12.w,
                                    runSpacing: 16.h,
                                    children: viewModel.products.map((product) {
                                      final isSelected = viewModel
                                          .selectedProducts
                                          .contains(product);
                                      return GestureDetector(
                                        onTap: () =>
                                            viewModel.toggleProduct(product),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 14.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? null
                                                : AppColors.white,
                                            gradient: isSelected
                                                ? AppColors.primaryGradient
                                                : null,
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.grey.withValues(
                                                      alpha: 0.5,
                                                    ),
                                              width: isSelected ? 4 : 1,
                                            ),
                                            boxShadow: isSelected
                                                ? [
                                                    BoxShadow(
                                                      offset: Offset(0, -1),
                                                      blurRadius: 8,
                                                      color: AppColors.black
                                                          .withValues(
                                                            alpha: 0.04,
                                                          ),
                                                    ),
                                                    BoxShadow(
                                                      color: AppColors.gold
                                                          .withValues(
                                                            alpha: 0.2,
                                                          ),
                                                      blurRadius: 20,
                                                      offset: const Offset(
                                                        -4,
                                                        12,
                                                      ),
                                                      spreadRadius: 6,
                                                    ),
                                                    BoxShadow(
                                                      color: AppColors.gold
                                                          .withValues(
                                                            alpha: 0.40,
                                                          ),
                                                      blurRadius: 10,
                                                      offset: const Offset(
                                                        0,
                                                        4,
                                                      ),
                                                    ),
                                                  ]
                                                : [],
                                          ),
                                          child: Text(
                                            product,
                                            style: TextStyle(
                                              fontFamily: AppFonts.lato,
                                              fontSize: 18.sp,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                              color: isSelected
                                                  ? AppColors.black
                                                  : AppColors.darkGrey,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  40.verticalSpace,
                                ],
                              ),
                            ),
                          ),
                          // Top Shadow
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: 32.h,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.white,
                                    AppColors.white.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Bottom Shadow
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 48.h,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.white,
                                    AppColors.white.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    24.verticalSpace,

                    // Add Other Field / Button
                    viewModel.isAddingCustom
                        ? Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.black,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _customProductController,
                                    focusNode: _focusNode,
                                    style: TextStyle(
                                      fontFamily: AppFonts.lato,
                                      fontSize: 16.sp,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppStrings.typeProductHint,
                                      hintStyle: TextStyle(
                                        fontFamily: AppFonts.lato,
                                        color: AppColors.hintGrey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        viewModel.addCustomProduct(value);
                                      }
                                      viewModel.setIsAddingCustom(false);
                                      _customProductController.clear();
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_customProductController
                                        .text
                                        .isNotEmpty) {
                                      viewModel.addCustomProduct(
                                        _customProductController.text,
                                      );
                                    }
                                    viewModel.setIsAddingCustom(false);
                                    _customProductController.clear();
                                  },
                                  child: Text(
                                    AppStrings.addLabel,
                                    style: TextStyle(
                                      fontFamily: AppFonts.lato,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.black,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              viewModel.setIsAddingCustom(true);
                              _focusNode.requestFocus();
                            },
                            child: CustomPaint(
                              painter: DashedBorderPainter(
                                color: AppColors.grey,
                                strokeWidth: 1.5,
                                dashWidth: 6,
                                gap: 6,
                                borderRadius: 16.r,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 14.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.addOtherLabel,
                                      style: TextStyle(
                                        fontFamily: AppFonts.lato,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    Icon(
                                      Icons.add,
                                      color: AppColors.black,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                    24.verticalSpace,

                    // Next / Analyzing Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: viewModel.isAnalyzing
                            ? null
                            : () {
                                viewModel.startAnalysis(() {
                                  // Can perform navigation here.

                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FeatureAuditScreen(),
                                    ),
                                  );
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black87,
                          foregroundColor: AppColors.white,
                          disabledBackgroundColor: AppColors.black87,
                          disabledForegroundColor: AppColors.white,
                          elevation: viewModel.isAnalyzing ? 0 : 4,
                          shadowColor: AppColors.blackShadow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          viewModel.isAnalyzing
                              ? AppStrings.analyzingWait
                              : AppStrings.nextButton,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashWidth;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.dashWidth = 5.0,
    this.borderRadius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    Path path = Path()..addRRect(rRect);

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        Path extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
