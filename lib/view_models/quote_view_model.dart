import 'dart:async';
import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../core/consts/app_images.dart';

class QuoteViewModel extends ChangeNotifier {
  static const List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
  ];

  final List<String> quotes = AppStrings.quotes;

  // Order of avatar indices in the 3 visual slots [back, middle, front]
  // ignore: prefer_final_fields
  List<int> _order = [0, 1, 2];
  List<int> get order => _order;

  // The front slot (index 2) is always the "active/colorful" one
  int get activeSlot => 2;
  int get activeAvatarIdx => _order[activeSlot];

  // Intro state
  bool _introComplete = false;
  bool get introComplete => _introComplete;

  // Animation phase: true while avatars are mid-transition
  bool _isTransitioning = false;
  bool get isTransitioning => _isTransitioning;

  // The avatar index that is departing (was active, now sliding to back)
  int? _departingAvatarIdx;
  int? get departingAvatarIdx => _departingAvatarIdx;

  Timer? _cycleTimer;

  void markIntroComplete() {
    _introComplete = true;
    notifyListeners();
    _startCycling();
  }

  void _startCycling() {
    _cycleTimer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      _beginTransition();
    });
  }

  void _beginTransition() {
    // Mark the current front avatar as departing
    _departingAvatarIdx = _order[activeSlot];
    _isTransitioning = true;

    // Rotate: front goes to back
    final last = _order.removeLast();
    _order.insert(0, last);
    notifyListeners();

    // After animation completes, clear transitioning state
    Future.delayed(const Duration(milliseconds: 500), () {
      _isTransitioning = false;
      _departingAvatarIdx = null;
      notifyListeners();
    });
  }

  String get currentQuote => quotes[activeAvatarIdx % quotes.length];

  @override
  void dispose() {
    _cycleTimer?.cancel();
    super.dispose();
  }
}
