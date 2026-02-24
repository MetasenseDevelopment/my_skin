import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_strings.dart';
import '../../core/utils/widgets/glassy_app_bar.dart';
import '../../view_models/analysis_view_model.dart';
import '../empathy_screen/empathy_screen.dart';

class AnalysisFullReportScreen extends StatelessWidget {
  const AnalysisFullReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: const GlassyAppBar(),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderArea(context),
                    _buildSummary(),
                    _buildMetrics(),
                    _buildFindings(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
              child: _buildNextButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderArea(BuildContext context) {
    return SizedBox(
      height: 480.h,
      width: double.infinity,
      child: Consumer<AnalysisViewModel>(
        builder: (context, vm, child) {
          return Stack(
            children: [
              // 1. The central image with highly rounded corners
              Positioned(
                top: 0,
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.r),
                  child: vm.frontImagePath != null
                      ? Image.file(File(vm.frontImagePath!), fit: BoxFit.cover)
                      : Container(color: Colors.grey.shade300),
                ),
              ),

              // 2. Left White Overlay Cutout (S-Curve Illusion)
              Positioned(
                top: 0,
                left: 0,
                width: 130.w,
                height: 80.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "72",
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 48.sp,
                          color: AppColors.black,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        AppStrings.skinScoreTitle,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 10.sp,
                          color: AppColors.black,
                          letterSpacing: 1,
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
                width: 130.w,
                height: 80.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "03",
                        style: TextStyle(
                          fontFamily: AppFonts.playfairDisplay,
                          fontSize: 48.sp,
                          color: AppColors.reportRed,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        AppStrings.issuesFoundTitle,
                        style: TextStyle(
                          fontFamily: AppFonts.lato,
                          fontSize: 10.sp,
                          color: AppColors.black,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 4. "FRONT VIEW" Pill
              Positioned(
                top: 16.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      AppStrings.frontView,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 10.sp,
                        color: Colors.white,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              // 5. Left Arrow
              Positioned(
                top: 200.h,
                left: 32.w,
                child: _buildImageControlArrow(Icons.chevron_left),
              ),

              // 6. Right Arrow
              Positioned(
                top: 200.h,
                right: 32.w,
                child: _buildImageControlArrow(Icons.chevron_right),
              ),

              // 7. Pagination Dots at bottom of image
              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.yellowColor,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    4.horizontalSpace,
                    _buildDot(),
                    4.horizontalSpace,
                    _buildDot(),
                    4.horizontalSpace,
                    _buildDot(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageControlArrow(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withValues(alpha: 0.4),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
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
      padding: EdgeInsets.symmetric(horizontal: 24.w),
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
          16.verticalSpace,
          Text(
            AppStrings.frAnalysisSummaryText,
            style: TextStyle(
              fontFamily: AppFonts.lato,
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              height: 1.6,
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
              fontWeight: FontWeight.bold,
              color: AppColors.sectionTitleBrown,
            ),
          ),
          32.verticalSpace,
          _buildFindingItem(
            AppStrings.acneBreakoutsTitle,
            AppStrings.mediumSeverity,
            AppColors.tagMediumBg,
            AppColors.tagMediumText,
            AppStrings.acneBreakoutsText,
            AppStrings.acneBreakoutsQuote,
          ),
          32.verticalSpace,
          _buildFindingItem(
            AppStrings.enlargedPoresTitle,
            AppStrings.lowSeverity,
            AppColors.tagLowBg,
            AppColors.tagLowText,
            AppStrings.enlargedPoresText,
            AppStrings.enlargedPoresQuote,
          ),
          32.verticalSpace,
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
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: tagColor,
                ),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.lato,
            fontSize: 14.sp,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.quoteBg,
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
