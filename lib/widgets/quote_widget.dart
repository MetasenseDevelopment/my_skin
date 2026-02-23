import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/consts/app_colors.dart';
import '../view_models/quote_view_model.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  State<QuoteWidget> createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget>
    with TickerProviderStateMixin {
  late final List<AnimationController> _introControllers;
  late final List<Animation<double>> _introScale;
  late final List<Animation<double>> _introFade;

  static const _greyscaleMatrix = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  void initState() {
    super.initState();

    _introControllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    _introScale = _introControllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.elasticOut);
    }).toList();

    _introFade = _introControllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.easeIn);
    }).toList();

    _playIntro();
  }

  Future<void> _playIntro() async {
    final vm = context.read<QuoteViewModel>();
    for (int i = 0; i < _introControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      _introControllers[i].forward();
    }
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    vm.markIntroComplete();
  }

  @override
  void dispose() {
    for (final c in _introControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final positions = [0.0, 20.w, 40.w];

    return Consumer<QuoteViewModel>(
      builder: (context, vm, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.w,
              height: 60.h,
              child: vm.introComplete
                  ? _buildCyclingStack(vm, positions)
                  : _buildIntroStack(),
            ),
            8.horizontalSpace,
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  vm.currentQuote,
                  key: ValueKey<String>(vm.currentQuote),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontStyle: FontStyle.italic,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Intro stack (staggered pop-in) ──
  Widget _buildIntroStack() {
    return Stack(
      children: [
        _buildIntroAvatar(0, 0),
        _buildIntroAvatar(1, 20.w),
        _buildIntroAvatar(2, 40.w),
      ],
    );
  }

  Widget _buildIntroAvatar(int index, double left) {
    final isLast = index == 2;
    return Positioned(
      left: left,
      top: 0,
      bottom: 0,
      child: Center(
        child: FadeTransition(
          opacity: _introFade[index],
          child: ScaleTransition(
            scale: _introScale[index],
            child: _avatarCircle(avatarIdx: index, isActive: isLast),
          ),
        ),
      ),
    );
  }

  // ── Cycling stack with carousel z-order ──
  Widget _buildCyclingStack(QuoteViewModel vm, List<double> positions) {
    // Build widgets for each slot
    final slotWidgets = <_SlotData>[];
    for (int slot = 0; slot < 3; slot++) {
      final avatarIdx = vm.order[slot];
      final isActive = slot == vm.activeSlot;
      // During transition, the departing avatar goes behind everything
      final isDeparting =
          vm.isTransitioning && avatarIdx == vm.departingAvatarIdx;

      slotWidgets.add(
        _SlotData(
          widget: AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            left: positions[slot],
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedScale(
                scale: isActive ? 1.0 : 0.9,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                child: _avatarCircle(avatarIdx: avatarIdx, isActive: isActive),
              ),
            ),
          ),
          isActive: isActive,
          isDeparting: isDeparting,
        ),
      );
    }

    // Z-order: departing at bottom, then non-active, active on top
    slotWidgets.sort((a, b) {
      if (a.isDeparting) return -1;
      if (b.isDeparting) return 1;
      if (a.isActive) return 1;
      if (b.isActive) return -1;
      return 0;
    });

    return Stack(children: slotWidgets.map((s) => s.widget).toList());
  }

  // ── Shared avatar circle ──
  Widget _avatarCircle({required int avatarIdx, required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.accentYellow : AppColors.white,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: isActive
          ? CircleAvatar(
              radius: 25.r,
              backgroundImage: AssetImage(QuoteViewModel.avatars[avatarIdx]),
            )
          : ColorFiltered(
              colorFilter: _greyscaleMatrix,
              child: CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage(QuoteViewModel.avatars[avatarIdx]),
              ),
            ),
    );
  }
}

// Helper to track z-order sorting
class _SlotData {
  final Widget widget;
  final bool isActive;
  final bool isDeparting;

  _SlotData({
    required this.widget,
    required this.isActive,
    required this.isDeparting,
  });
}
