import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../view_models/camera_view_model.dart';

class AnalysisViewModel extends ChangeNotifier {
  String? _frontImagePath;
  String? _rightImagePath;
  String? _leftImagePath;

  String? get frontImagePath => _frontImagePath;
  String? get rightImagePath => _rightImagePath;
  String? get leftImagePath => _leftImagePath;

  String get analysisTitle => AppStrings.analysisTitle;
  String get analyzingText => AppStrings.analyzingText;
  String get analysisSubtext => AppStrings.analysisSubtext;

  // Card rotation (Rise Baby pattern)
  int _cardRotationIndex = 0;
  int get cardRotationIndex => _cardRotationIndex;
  bool _isActive = true;

  void loadImages(Map<CameraStep, XFile> capturedImages) {
    _frontImagePath = capturedImages[CameraStep.front]?.path;
    _rightImagePath = capturedImages[CameraStep.right]?.path;
    _leftImagePath = capturedImages[CameraStep.left]?.path;
    notifyListeners();
  }

  void startCardAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    while (_isActive) {
      _cardRotationIndex = (_cardRotationIndex + 1) % 3;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 3));
    }
  }

  @override
  void dispose() {
    _isActive = false;
    super.dispose();
  }
}
