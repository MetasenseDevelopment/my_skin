import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_icons.dart';
import '../../view_models/camera_view_model.dart';
import '../analysis_screen/analysis_screen.dart';
import '../../core/utils/widgets/glassy_app_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cameraVM = context.read<CameraViewModel>();
      cameraVM.initCamera();

      // Listen for when all 3 images are captured
      cameraVM.addListener(() {
        if (cameraVM.allCaptured && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AnalysisScreen()),
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
      backgroundColor: Colors.black, // true black for camera background
      body: Consumer<CameraViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Camera Preview Layer
              if (viewModel.isInitialized && viewModel.cameraController != null)
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: viewModel.cameraController!.value.aspectRatio,
                    child: CameraPreview(viewModel.cameraController!),
                  ),
                )
              else
                // Loading or testing fallback
                Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                ),

              // 2. Top "FRONT VIEW" / "LEFT VIEW" pill
              Positioned(
                top: 54.h,
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
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      viewModel.stepTitle,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ),

              // 3. Bottom Camera Controls Layer
              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Gallery Box
                      GestureDetector(
                        onTap: () => viewModel.pickFromGallery(context),
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: viewModel.lastCapturedImage != null
                                ? Image.file(
                                    File(viewModel.lastCapturedImage!.path),
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Iconify(
                                      AppIcons.gallery,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      // Capture Shutter Button
                      GestureDetector(
                        onTap: () => viewModel.captureImage(context),
                        child: Container(
                          width: 72.w,
                          height: 72.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 4.w,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 54.w,
                              height: 54.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                gradient: RadialGradient(
                                  colors: [Colors.white, Colors.grey.shade400],
                                  stops: [0.3, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Flip Camera Icon
                      GestureDetector(
                        onTap: () => viewModel.switchCamera(),
                        child: Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Iconify(
                              AppIcons.flipCamera,
                              color: Colors.white,
                              size: 32.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
