import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum CameraStep { front, right, left }

class CameraViewModel extends ChangeNotifier {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;

  CameraStep _currentStep = CameraStep.front;

  final Map<CameraStep, XFile> _capturedImages = {};

  CameraController? get cameraController => _cameraController;
  bool get isInitialized => _isInitialized;
  CameraStep get currentStep => _currentStep;
  Map<CameraStep, XFile> get capturedImages => _capturedImages;

  bool _allCaptured = false;
  bool get allCaptured => _allCaptured;

  // The last captured image (for the gallery thumbnail preview)
  XFile? get lastCapturedImage {
    if (_capturedImages.isNotEmpty) {
      return _capturedImages.values.last;
    }
    return null;
  }

  String get stepTitle {
    switch (_currentStep) {
      case CameraStep.front:
        return 'FRONT VIEW';
      case CameraStep.right:
        return 'RIGHT VIEW';
      case CameraStep.left:
        return 'LEFT VIEW';
    }
  }

  Future<void> initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        CameraDescription? frontCamera;
        try {
          frontCamera = _cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
          );
        } catch (_) {
          frontCamera = _cameras.first;
        }

        await _setCamera(frontCamera);
      }
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  Future<void> _setCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> switchCamera() async {
    if (_cameras.isEmpty || _cameraController == null) return;

    final currentDir = _cameraController!.description.lensDirection;
    CameraDescription? nextCamera;
    try {
      if (currentDir == CameraLensDirection.front) {
        nextCamera = _cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
        );
      } else {
        nextCamera = _cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.front,
        );
      }
    } catch (_) {
      nextCamera = _cameras.firstWhere(
        (c) => c != _cameraController!.description,
        orElse: () => _cameras.first,
      );
    }

    if (nextCamera != _cameraController!.description) {
      _isInitialized = false;
      notifyListeners();
      await _setCamera(nextCamera);
    }
  }

  Future<void> captureImage(BuildContext context) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();
      if (!context.mounted) return;
      _handleImageCapture(image, context);
    } catch (e) {
      debugPrint("Error capturing image: $e");
    }
  }

  Future<void> pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (!context.mounted) return;
    if (image != null) {
      _handleImageCapture(image, context);
    }
  }

  void _handleImageCapture(XFile image, BuildContext context) {
    _capturedImages[_currentStep] = image;

    if (_currentStep == CameraStep.front) {
      _currentStep = CameraStep.right;
    } else if (_currentStep == CameraStep.right) {
      _currentStep = CameraStep.left;
    } else {
      _allCaptured = true;
    }
    notifyListeners();
  }

  void resetCapture() {
    _capturedImages.clear();
    _currentStep = CameraStep.front;
    _allCaptured = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
