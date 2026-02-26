import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  int _activeDot = 0;
  bool _isAnimating = false;

  int get activeDot => _activeDot;
  bool get isAnimating => _isAnimating;

  void startAnimation() {
    if (_isAnimating) return;
    _isAnimating = true;
    notifyListeners();
    _runLoop();
  }

  void stopAnimation() {
    _isAnimating = false;
  }

  /// Called on swipe right → advance to next dot
  void swipeNext() {
    _activeDot = (_activeDot + 1) % 3;
    notifyListeners();
  }

  /// Called on swipe left → go back to previous dot
  void swipePrev() {
    _activeDot = (_activeDot - 1 + 3) % 3;
    notifyListeners();
  }

  void _runLoop() async {
    while (_isAnimating) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!_isAnimating) break;
      _activeDot = (_activeDot + 1) % 3;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    stopAnimation();
    super.dispose();
  }
}
