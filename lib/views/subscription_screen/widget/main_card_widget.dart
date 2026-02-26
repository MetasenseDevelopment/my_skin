// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_images.dart';
import 'package:my_skin/views/subscription_screen/widget/myskin_logo_widget.dart';

// ---------------------------------------------------------------------------
// Review data model
// ---------------------------------------------------------------------------
class _Review {
  final String text;
  final List<String> avatars; // 3 avatars per review

  const _Review({required this.text, required this.avatars});
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------
class MainCardWidget extends StatefulWidget {
  const MainCardWidget({super.key});

  @override
  State<MainCardWidget> createState() => _MainCardWidgetState();
}

class _MainCardWidgetState extends State<MainCardWidget> {
  // ── Plan selection ──────────────────────────────────────────────────────
  String _selectedPlan = 'yearly';

  // ── Reviews ─────────────────────────────────────────────────────────────
  final List<_Review> _reviews = const [
    _Review(
      text: '"Transformed my approach to skin!"',
      avatars: [AppImages.avatar1, AppImages.avatar2, AppImages.avatar3],
    ),
    _Review(
      text: '"Game-changer for my skin routine!"',
      avatars: [AppImages.avatar2, AppImages.avatar3, AppImages.avatar1],
    ),
    _Review(
      text: '"Best skincare app I\'ve ever used!"',
      avatars: [AppImages.avatar3, AppImages.avatar1, AppImages.avatar2],
    ),
  ];

  int _currentReview = 0;
  late Timer _reviewTimer;

  @override
  void initState() {
    super.initState();
    // Auto-advance review every 2 seconds
    _reviewTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        _currentReview = (_currentReview + 1) % _reviews.length;
      });
    });
  }

  @override
  void dispose() {
    _reviewTimer.cancel();
    super.dispose();
  }

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final review = _reviews[_currentReview];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 23,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 42,
            offset: const Offset(0, 40),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌹 Logo
          MySkinLogo(lightBackground: true),
          SizedBox(height: 16.h),

          // ✨ Headline
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30.sp,
                fontFamily: AppFonts.playfairDisplay,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlack,
                height: 1.25,
              ),
              children: const [
                TextSpan(text: "Your personalized\nskin-care "),
                TextSpan(
                  text: "– just a\nstep away.",
                  style: TextStyle(
                    color: Color(0xFFC9A14A),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h),

          // ⭐ Review carousel row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Overlapping avatars — animate when review changes
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _buildAvatars(
                  review.avatars,
                  key: ValueKey(_currentReview),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ Stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star_rounded,
                          size: 17,
                          color: Color(0xFFC9A14A),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // Review text — fade in/out on change
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: Text(
                        review.text,
                        key: ValueKey(review.text),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: AppFonts.lato,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          // 💎 YEARLY PLAN with floating "7 DAY FREE TRIAL" badge
          _yearlyPlanCard(),
          SizedBox(height: 12.h),

          // 💎 WEEKLY PLAN
          _planCard(
            planKey: 'weekly',
            title: "WEEKLY PLAN",
            subtitle: "Billed weekly",
            price: "\$ 2.66",
            period: "/wk",
          ),
        ],
      ),
    );
  }

  // ── Overlapping avatars ──────────────────────────────────────────────────
  Widget _buildAvatars(List<String> avatars, {required Key key}) {
    const double radius = 20;
    const double overlap = 14;
    const double size = radius * 2;
    final double totalWidth = size + overlap * (avatars.length - 1);

    return SizedBox(
      key: key,
      width: totalWidth,
      height: size,
      child: Stack(
        children: List.generate(avatars.length, (i) {
          // Active avatar index rotates with _currentReview (0 → 1 → 2 → ...)
          final bool isActive = i == _currentReview % avatars.length;
          return Positioned(
            left: i * overlap,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ✅ Selected (front) avatar = gold border, others = white
                border: Border.all(
                  color: isActive ? const Color(0xFFC9A14A) : Colors.white,
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage(avatars[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Yearly card with floating badge ─────────────────────────────────────
  Widget _yearlyPlanCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _planCard(
          planKey: 'yearly',
          title: "YEARLY PLAN",
          subtitle: "\$0.00 for 7 days",
          price: "\$ 19.66",
          period: "/yr",
          extraTopPadding: 16.h,
        ),

        // 🎁 "7 DAY FREE TRIAL" pill — floats on top-right border
        Positioned(
          top: -15.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: const Color(0xFFC9A14A),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC9A14A).withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "7 DAY FREE TRIAL",
              style: TextStyle(
                fontFamily: AppFonts.lato,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Plan card ────────────────────────────────────────────────────────────
  Widget _planCard({
    required String planKey,
    required String title,
    required String subtitle,
    required String price,
    required String period,
    double extraTopPadding = 0,
  }) {
    final bool isSelected = _selectedPlan == planKey;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = planKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.only(
          top: 16.h + extraTopPadding,
          bottom: 16.h,
          left: 16.w,
          right: 16.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            // ✅ Selected = gold border, Unselected = white border
            color: isSelected ? const Color(0xFFC9A14A) : Colors.white,
            width: 1.5,
          ),
          boxShadow: [
            // Always show a subtle shadow so unselected card is visible
            BoxShadow(
              blurRadius: isSelected ? 16 : 8,
              color: isSelected
                  ? const Color(0xFFC9A14A).withOpacity(0.15)
                  : Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: title + subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 11.sp,
                    letterSpacing: 1.8,
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // Right: price
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontFamily: AppFonts.lato,
                      fontWeight: FontWeight.w700,
                      fontSize: 26.sp,
                    ),
                  ),
                  TextSpan(
                    text: period,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontFamily: AppFonts.lato,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
