import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/consts/app_images.dart';

class AnimatedCameraImage extends StatefulWidget {
  const AnimatedCameraImage({super.key});

  @override
  State<AnimatedCameraImage> createState() => _AnimatedCameraImageState();
}

class _AnimatedCameraImageState extends State<AnimatedCameraImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Loops back and forth

    _animation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Center(
        child: Image.asset(
          AppImages.camera,
          height: 250.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
