import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_strings.dart';

import '../../view_models/analysis_view_model.dart';
import '../empathy_screen/empathy_screen.dart';

class AnalysisFullReportScreen extends StatefulWidget {
  const AnalysisFullReportScreen({super.key});

  @override
  State<AnalysisFullReportScreen> createState() =>
      _AnalysisFullReportScreenState();
}

class _AnalysisFullReportScreenState extends State<AnalysisFullReportScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _viewTitles = [
    AppStrings.frontView,
    'RIGHT VIEW',
    'LEFT VIEW',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h), // Extra space for button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderArea(context),
                  40.verticalSpace,
                  _buildSummary(),
                  _buildMetrics(),
                  _buildFindings(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 16.h,
                  bottom: MediaQuery.of(context).padding.bottom > 0
                      ? MediaQuery.of(context).padding.bottom + 12.h
                      : 24.h,
                ),
                color: Colors.transparent, // Fully transparent so data shows
                child: _buildNextButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 520.h,
        width: double.infinity,
        child: Consumer<AnalysisViewModel>(
          builder: (context, vm, child) {
            // Get available images
            List<String?> images = [
              vm.frontImagePath,
              vm.rightImagePath,
              vm.leftImagePath,
            ];

            return ClipRRect(
              borderRadius: BorderRadius.circular(40.r),
              child: Stack(
                children: [
                  // 1. Central PageView for images
                  Positioned.fill(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final path = images[index];
                        return path != null
                            ? Image.file(File(path), fit: BoxFit.cover)
                            : Container(color: Colors.grey.shade300);
                      },
                    ),
                  ),

                  // 2. Left White Overlay Cutout
                  Positioned(
                    top: 0,
                    left: 0,
                    width: 125.w,
                    height: 100.h,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(45.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "72",
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black87,
                              height: 1.0,
                            ),
                          ),
                          8.verticalSpace,
                          Text(
                            AppStrings.skinScoreTitle,
                            style: TextStyle(
                              fontFamily: AppFonts.lato,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 3. Right White Overlay Cutout
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 125.w,
                    height: 100.h,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45.r),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "03",
                            style: TextStyle(
                              fontFamily: AppFonts.playfairDisplay,
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.reportRed,
                              height: 1.0,
                            ),
                          ),
                          8.verticalSpace,
                          Text(
                            AppStrings.issuesFoundTitle,
                            style: TextStyle(
                              fontFamily: AppFonts.lato,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 4. "FRONT VIEW" Pill (Dynamic based on current index)
                  Positioned(
                    top: 16.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        height: 36.h,
                        width: 106.w,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.grey, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            _viewTitles[_currentIndex],
                            style: TextStyle(
                              fontFamily: AppFonts.lato,
                              fontSize: 14.sp,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 5. Left Arrow
                  Positioned(
                    top: 336.h,
                    left: 16.w,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentIndex > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: _buildImageControlArrow(Icons.chevron_left),
                    ),
                  ),

                  // 6. Right Arrow
                  Positioned(
                    top: 336.h,
                    right: 16.w,
                    child: GestureDetector(
                      onTap: () {
                        if (_currentIndex < images.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: _buildImageControlArrow(Icons.chevron_right),
                    ),
                  ),

                  // 7. Pagination Dots at bottom of image
                  Positioned(
                    bottom: 24.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: _currentIndex == index
                              ? Container(
                                  width: 23.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.yellowColor,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                )
                              : _buildDot(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageControlArrow(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.2),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Icon(icon, color: Colors.white, size: 20.w),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 6.w,
      height: 6.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.frAnalysisSummaryTitle,
            style: TextStyle(
              fontFamily: AppFonts.playfairDisplay,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          8.verticalSpace,
          Text(
            AppStrings.frAnalysisSummaryText,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrics() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.skinMetricsTitle,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: AppColors.black,
            ),
          ),
          24.verticalSpace,
          _buildMetricRow(
            AppStrings.textureLabel,
            0.7,
            AppColors.progressGreen,
          ),
          16.verticalSpace,
          _buildMetricRow(
            AppStrings.hydrationLabel,
            0.6,
            AppColors.progressGreen,
          ),
          16.verticalSpace,
          _buildMetricRow(AppStrings.glowLabel, 0.4, AppColors.progressRed),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, double progress, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 6.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.progressBg,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFindings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.detailedFindingsTitle,
            style: TextStyle(
              fontFamily: AppFonts.playfairDisplay,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.orange,
            ),
          ),
          16.verticalSpace,
          _buildFindingItem(
            AppStrings.acneBreakoutsTitle,
            AppStrings.mediumSeverity,
            AppColors.gold.withValues(alpha: 0.12),
            AppColors.orange,
            AppStrings.acneBreakoutsText,
            AppStrings.acneBreakoutsQuote,
          ),
          28.verticalSpace,
          Divider(),
          28.verticalSpace,
          _buildFindingItem(
            AppStrings.enlargedPoresTitle,
            AppStrings.lowSeverity,
            AppColors.darkGreen.withValues(alpha: 0.15),
            AppColors.darkGreen,
            AppStrings.enlargedPoresText,
            AppStrings.enlargedPoresQuote,
          ),
          28.verticalSpace,
          Divider(),
          28.verticalSpace,
          _buildFindingItem(
            AppStrings.darkCirclesTitle,
            AppStrings.lowSeverity,
            AppColors.tagLowBg,
            AppColors.tagLowText,
            AppStrings.darkCirclesText,
            AppStrings.darkCirclesQuote,
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildFindingItem(
    String title,
    String tag,
    Color tagBg,
    Color tagColor,
    String text,
    String quote,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.lato,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: tagBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontFamily: AppFonts.lato,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: tagColor,
                ),
              ),
            ),
          ],
        ),
        12.5.verticalSpace,
        Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.lato,
            fontSize: 16.sp,
            color: AppColors.darkGrey,
            height: 1.5,
          ),
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            quote,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 13.sp,
              color: AppColors.black,
              fontStyle: FontStyle.italic, // italic for quotes
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 64.h,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EmpathyScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 5,
            shadowColor: Colors.black.withValues(alpha: 0.3),
          ),
          child: Text(
            AppStrings.nextButton,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 18.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
