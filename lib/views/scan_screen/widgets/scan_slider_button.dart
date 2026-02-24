import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/consts/app_colors.dart';
import '../../../core/consts/app_fonts.dart';
import '../../../core/consts/app_icons.dart';
import '../../../view_models/scan_view_model.dart';

class ScanSliderButton extends StatelessWidget {
  final String text;
  final VoidCallback onSlideComplete;

  const ScanSliderButton({
    super.key,
    required this.text,
    required this.onSlideComplete,
  });

  @override
  Widget build(BuildContext context) {
    final double knobWidth = 90.w;
    final double buttonHeight = 64.h;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxDragPosition =
            constraints.maxWidth - knobWidth - 8.w; // 8.w for padding

        return Consumer<ScanViewModel>(
          builder: (context, viewModel, child) {
            final double dragPosition =
                viewModel.slideProgress * maxDragPosition;

            return Container(
              height: buttonHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(buttonHeight / 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withValues(alpha: 0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Background Text
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: AppFonts.lato,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),

                  // Draggable Knob
                  Positioned(
                    left: 4.w + dragPosition,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        double newDragPos = (dragPosition + details.delta.dx)
                            .clamp(0.0, maxDragPosition);

                        // Update view model progress without setState
                        viewModel.updateSlideProgress(
                          newDragPos / maxDragPosition,
                        );
                      },
                      onHorizontalDragEnd: (details) {
                        if (dragPosition > maxDragPosition * 0.9) {
                          // Complete
                          viewModel.updateSlideProgress(1.0);
                          onSlideComplete();
                        } else {
                          // Snap back
                          viewModel.resetSlide();
                        }
                      },
                      child: Container(
                        width: knobWidth,
                        height: buttonHeight - 8.w, // Subtract padding
                        decoration: BoxDecoration(
                          color: AppColors.black87,
                          borderRadius: BorderRadius.circular(
                            (buttonHeight - 8.w) / 2,
                          ),
                          border: Border.all(
                            color: AppColors.yellowColor,
                            width: 1.5.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.yellowColor.withValues(
                                alpha: 0.25,
                              ),
                              blurRadius: 15,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Iconify(
                                AppIcons.imageScan,
                                color: AppColors.white,
                                size: 24.sp,
                              ),
                              Iconify(
                                AppIcons.arrowRight,
                                color: AppColors.white,
                                size: 24.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
