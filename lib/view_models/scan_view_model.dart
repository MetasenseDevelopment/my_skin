import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../models/scan_model.dart';

class ScanViewModel extends ChangeNotifier {
  final ScanData _data = ScanData(
    subtitle: AppStrings.scanSubtitle,
    title: AppStrings.scanTitle,
    bullet1: AppStrings.scanBullet1,
    bullet2: AppStrings.scanBullet2,
    slideText: AppStrings.slideText,
  );

  ScanData get data => _data;

  // Track the slide progress (0.0 to 1.0)
  double _slideProgress = 0.0;
  double get slideProgress => _slideProgress;

  void updateSlideProgress(double progress) {
    _slideProgress = progress.clamp(0.0, 1.0);
    notifyListeners();

    if (_slideProgress == 1.0) {
      _triggerScanAction();
    }
  }

  void resetSlide() {
    _slideProgress = 0.0;
    notifyListeners();
  }

  void _triggerScanAction() {
    // TODO: Implement navigation to actual scanning camera logic
  }
}
