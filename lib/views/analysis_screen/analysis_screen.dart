import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../view_models/analysis_view_model.dart';
import '../../view_models/camera_view_model.dart';
import 'analysis_result_screen.dart';
import 'widgets/analysis_loading_dots.dart';
import '../../core/utils/widgets/glassy_app_bar.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cameraVM = context.read<CameraViewModel>();
      final analysisVM = context.read<AnalysisViewModel>();
      analysisVM.loadImages(cameraVM.capturedImages);
      analysisVM.startCardAnimation();

      // Navigate to AnalysisResultScreen after 10 seconds
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AnalysisResultScreen(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassyAppBar(),
      backgroundColor: AppColors.black87,
      body: SafeArea(
        top: false,
        child: Consumer<AnalysisViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                // === Large vertical "ANALYSIS" text on the right ===
                Positioned(
                  right: -15.w,
                  top: 20.h,
                  bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      viewModel.analysisTitle,
                      style: TextStyle(
                        fontFamily: AppFonts.playfairDisplay,
                        fontSize: 120.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellowColor.withValues(alpha: 0.3),
                        letterSpacing: 32,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),

                // === Main Content Column ===
                Column(
                  children: [
                    Spacer(flex: 1),

                    // === Image Carousel (Rise Baby pattern) ===
                    SizedBox(
                      height: 340.h,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: _buildAnimatedCards(viewModel),
                      ),
                    ),

                    Spacer(flex: 2),

                    // === Loading Row ===
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          const AnalysisLoadingDots(),
                          12.horizontalSpace,
                          Text(
                            viewModel.analyzingText,
                            style: TextStyle(
                              fontFamily: AppFonts.lato,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.yellowColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    16.verticalSpace,

                    // === Subtext ===
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          viewModel.analysisSubtext,
                          style: TextStyle(
                            fontFamily: AppFonts.lato,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.hintGrey,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),

                    40.verticalSpace,
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedCards(AnalysisViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = 200.w;
    final cardHeight = 280.h;

    final centerX = (screenWidth - cardWidth) / 2;
    // Half off-screen positions
    final rightX = screenWidth - (cardWidth / 2) - 10.w;
    final leftX = -(cardWidth / 2) + 10.w;

    final allPaths = [
      viewModel.frontImagePath,
      viewModel.rightImagePath,
      viewModel.leftImagePath,
    ];

    final cards = [
      {'path': allPaths[0], 'id': 0},
      {'path': allPaths[1], 'id': 1},
      {'path': allPaths[2], 'id': 2},
    ];

    final currentRotation = viewModel.cardRotationIndex;

    // Slot assignment: 0=Center, 1=Right, 2=Left
    int getSlot(int cardId, int state) {
      if (cardId == 0) return [0, 2, 1][state % 3];
      if (cardId == 1) return [1, 0, 2][state % 3];
      if (cardId == 2) return [2, 1, 0][state % 3];
      return 0;
    }

    Widget buildCardWidget(Map<String, dynamic> cardData) {
      final slot = getSlot(cardData['id'] as int, currentRotation);
      final imagePath = cardData['path'] as String?;

      double left;
      double scale;
      bool isCenter;

      switch (slot) {
        case 0: // Center
          left = centerX;
          scale = 1.0;
          isCenter = true;
          break;
        case 1: // Right
          left = rightX;
          scale = 0.75;
          isCenter = false;
          break;
        case 2: // Left
          left = leftX;
          scale = 0.75;
          isCenter = false;
          break;
        default:
          left = centerX;
          scale = 1.0;
          isCenter = true;
      }

      return AnimatedPositioned(
        key: ValueKey(cardData['id']),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutBack,
        left: left,
        top: 0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutBack,
          scale: scale,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isCenter
                    ? AppColors.yellowColor
                    : Colors.white.withValues(alpha: 0.2),
                width: isCenter ? 2.w : 1,
              ),
              boxShadow: isCenter
                  ? [
                      BoxShadow(
                        color: AppColors.yellowColor.withValues(alpha: 0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: imagePath != null
                  ? Image.file(File(imagePath), fit: BoxFit.cover)
                  : Container(color: Colors.grey.shade800),
            ),
          ),
        ),
      );
    }

    // Sort by z-index: center card (slot 0) on top
    cards.sort((a, b) {
      int slotA = getSlot(a['id'] as int, currentRotation);
      int slotB = getSlot(b['id'] as int, currentRotation);

      int zA = (slotA == 0) ? 2 : (slotA == 1 ? 1 : 0);
      int zB = (slotB == 0) ? 2 : (slotB == 1 ? 1 : 0);

      return zA.compareTo(zB);
    });

    return cards.map(buildCardWidget).toList();
  }
}
