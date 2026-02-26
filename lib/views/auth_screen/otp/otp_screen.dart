// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/views/auth_screen/newpassword/set_new_password_screen.dart';
import 'package:my_skin/views/auth_screen/widgets/email_signup_button_widget.dart';
import 'package:my_skin/widgets/rose_widget.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value, AuthProvider viewModel) {
    if (value.length > 1) {
      // Handle paste: distribute digits across boxes
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < 4 && i < digits.length; i++) {
        _controllers[i].text = digits[i];
        viewModel.updateOtpDigit(i, digits[i]);
      }
      final nextIndex = (digits.length < 4 ? digits.length : 3);
      FocusScope.of(context).requestFocus(_focusNodes[nextIndex]);
      return;
    }

    viewModel.updateOtpDigit(index, value);

    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  void _onKeyEvent(int index, KeyEvent event, AuthProvider viewModel) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      _controllers[index - 1].clear();
      viewModel.updateOtpDigit(index - 1, '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Column(
                children: [
                  // ── Back button ──────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.chevron_left,
                              size: 22.sp,
                              color: Colors.black87,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black87,
                                fontFamily: AppFonts.lato,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.h),

                          // ── Rose logo ──────────────────────────────
                          RoseLogo(isActive: viewModel.isOtpValid),

                          SizedBox(height: 32.h),

                          // ── Title ──────────────────────────────────
                          Text(
                            'Enter OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: AppFonts.playfairDisplay,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // ── Subtitle ───────────────────────────────
                          Text(
                            'We have sent the verification code to your\nemail address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: AppFonts.lato,
                              color: Colors.black45,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // ── OTP boxes ──────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: _OtpBox(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  onChanged: (v) =>
                                      _onDigitChanged(index, v, viewModel),
                                  onKeyEvent: (e) =>
                                      _onKeyEvent(index, e, viewModel),
                                ),
                              );
                            }),
                          ),

                          // ── OTP error ──────────────────────────────
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: viewModel.otpError != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          size: 13.sp,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          viewModel.otpError!,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.redAccent,
                                            fontFamily: AppFonts.lato,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),

                          SizedBox(height: 20.h),

                          // ── Didn't receive / Resend ────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive it? ",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: AppFonts.lato,
                                  color: Colors.black45,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  for (final c in _controllers) {
                                    c.clear();
                                  }
                                  context.read<AuthProvider>().resendOtp(
                                    context,
                                  );
                                },
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: AppFonts.lato,
                                    color: AppColors.accentYellow,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          // ── Verify button ──────────────────────────
                          EmailSignupButtonWidget(
                            isLoading: viewModel.isLoading,
                            isActive: viewModel.isOtpValid,
                            width: double.infinity,
                            label: 'Verify',
                            onTap: () async {
                              await context.read<AuthProvider>().verifyOtp();
                              if (viewModel.status == AuthStatus.success &&
                                  context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const SetNewPasswordScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Footer ─────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Having trouble? ',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: AppFonts.lato,
                            color: Colors.black45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: AppFonts.lato,
                              color: AppColors.accentYellow,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Single OTP digit box ─────────────────────────────────────────────────────
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<KeyEvent> onKeyEvent;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onKeyEvent,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: onKeyEvent,
      child: SizedBox(
        width: 64.w,
        height: 64.w,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.lato,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: controller.text.isEmpty
                ? const Color(0xFFF5F5F5)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.black26, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: controller.text.isEmpty
                    ? Colors.transparent
                    : Colors.black26,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.black38, width: 1),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
