// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_images.dart';
import 'package:my_skin/view_models/splash_view_model.dart';
import 'package:provider/provider.dart';

class RoseDotsWidget extends StatefulWidget {
  const RoseDotsWidget({super.key});

  @override
  State<RoseDotsWidget> createState() => _RoseDotsWidgetState();
}

class _RoseDotsWidgetState extends State<RoseDotsWidget>
    with TickerProviderStateMixin {
  // ── 1. Burst: dots expand from center → orbit radius (600ms) ──────────
  late final AnimationController _burstController;
  late final Animation<double> _burstAnim;

  // ── 2. Orbit: dots rotate 360° over 5 seconds ─────────────────────────
  late final AnimationController _orbitController;
  late final Animation<double> _orbitAnim;

  // ── 3. Sink: dots shrink + fade back into image (400ms) ───────────────
  late final AnimationController _sinkController;
  late final Animation<double> _sinkAnim; // radius: 1.0 → 0.0
  late final Animation<double> _fadeAnim; // opacity: 1.0 → 0.0

  // ── 4. Reveal: dots fade in at start of each new cycle (400ms) ────────
  late final AnimationController _revealController;
  late final Animation<double> _revealAnim; // opacity: 0.0 → 1.0

  @override
  void initState() {
    super.initState();
    _setupControllers();
    _runCycle();
  }

  void _setupControllers() {
    _burstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _burstAnim = CurvedAnimation(
      parent: _burstController,
      curve: Curves.easeOutBack,
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _orbitAnim = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _orbitController, curve: Curves.linear));

    _sinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _sinkAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _sinkController, curve: Curves.easeIn));
    _fadeAnim = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _sinkController, curve: Curves.easeIn));

    // Reveal: smooth fade-in at the start of each cycle
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _revealAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.easeOut),
    );
  }

  // ── Infinite loop: burst → orbit → sink → 2s pause → repeat ──────────
  void _runCycle() async {
    while (mounted) {
      // Reset all controllers
      _burstController.reset();
      _orbitController.reset();
      _sinkController.reset();
      _revealController.reset();

      // 1. Reveal + Burst simultaneously — no blank gap
      _revealController.forward(); // fade in  ┐ both start
      await _burstController.forward(); //      ┘ same frame
      if (!mounted) return;

      // 2. Orbit one full round
      await _orbitController.forward();
      if (!mounted) return;

      // 3. Sink into image
      await _sinkController.forward();
      if (!mounted) return;

      // 4. Wait 2 seconds hidden
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      // 5. Advance title just before next burst — both happen same frame
      context.read<SplashViewModel>().swipeNext();
    }
  }

  @override
  void dispose() {
    _burstController.dispose();
    _orbitController.dispose();
    _sinkController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double containerSize = 350.w;
    final double roseSize = 170.w;
    final double dotSize = 40.w;
    final double orbitRadius = 140.w;
    const int dotCount = 8;

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _burstAnim,
          _orbitAnim,
          _sinkController,
          _revealController,
        ]),
        builder: (context, _) {
          // Combined radius: burst expands, sink collapses
          final currentRadius =
              orbitRadius *
              _burstAnim
                  .value // 0 → 1 on burst
                  *
              _sinkAnim.value; // 1 → 0 on sink

          final opacity = (_revealAnim.value * _fadeAnim.value).clamp(0.0, 1.0);

          return Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(dotCount, (index) {
                final baseAngle = (2 * pi / dotCount) * index - pi / 2;
                final totalAngle = baseAngle + _orbitAnim.value;

                final dx = currentRadius * cos(totalAngle);
                final dy = currentRadius * sin(totalAngle);

                final dotScale = (_burstAnim.value * _sinkAnim.value).clamp(
                  0.0,
                  1.0,
                );

                return Positioned(
                  left: containerSize / 2 + dx - dotSize / 2,
                  top: containerSize / 2 + dy - dotSize / 2,
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: dotScale,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: AppColors.goldColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                width: roseSize,
                height: roseSize,
                child: Image.asset(AppImages.roseLogo, fit: BoxFit.contain),
              ),
            ],
          );
        },
      ),
    );
  }
}
