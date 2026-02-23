import 'package:flutter/material.dart';
import '../../../core/consts/app_images.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
  static const _images = AppImages.userInfoCarousel;

  // Original pixel dimensions for each image (in carousel order: 2, 3, 1)
  // userinfo2: 440×507, userinfo3: 440×507, userinfo1: 440×338
  static const _aspectRatios = [
    507.0 / 440.0, // userinfo2
    507.0 / 440.0, // userinfo3
    338.0 / 440.0, // userinfo1
  ];

  late final AnimationController _controller;

  // Total duration for one full cycle
  static const _cycleDuration = Duration(seconds: 18);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _cycleDuration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final viewportHeight = screenWidth * 1.1;

    return SizedBox(
      width: screenWidth,
      height: viewportHeight,
      child: Stack(
        children: [
          ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return _buildScrollingImages(screenWidth, viewportHeight);
              },
            ),
          ),
          // Bottom shadow gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: viewportHeight * 0.15,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.0),
                    Colors.white.withValues(alpha: 0.8),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingImages(double screenWidth, double viewportHeight) {
    // Calculate the actual scaled height for each image at full screen width
    final heights = _aspectRatios.map((ar) => screenWidth * ar).toList();

    // Total height of all images combined (one full cycle)
    final totalHeight = heights.reduce((a, b) => a + b);

    // Current scroll offset
    final offset = _controller.value * totalHeight;

    return Stack(
      children: List.generate(_images.length, (i) {
        // Calculate cumulative top position for this image
        double baseTop = 0;
        for (int j = 0; j < i; j++) {
          baseTop += heights[j];
        }

        double top = baseTop - offset;

        // Wrap around for seamless looping
        if (top + heights[i] < 0) {
          top += totalHeight;
        }

        return Positioned(
          top: top,
          left: 0,
          right: 0,
          height: heights[i],
          child: Image.asset(
            _images[i],
            width: screenWidth,
            height: heights[i],
            fit: BoxFit.fill,
          ),
        );
      }),
    );
  }
}
