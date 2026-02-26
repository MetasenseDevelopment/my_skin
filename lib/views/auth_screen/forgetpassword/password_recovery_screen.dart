// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/views/auth_screen/otp/otp_screen.dart';
import 'package:my_skin/widgets/custom_textform.dart';
import 'package:my_skin/widgets/rose_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/email_signup_button_widget.dart';
import 'package:provider/provider.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, viewModel, child) {
          final bool active = viewModel.isRecoveryFormActive;

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
                          RoseLogo(isActive: active),

                          SizedBox(height: 32.h),

                          // ── Title ──────────────────────────────────
                          Text(
                            AppStrings.passwordRecoveryTitle,
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
                            AppStrings.recoryLink,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: AppFonts.lato,
                              color: Colors.black45,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // ── Email field ────────────────────────────
                          CustomTextformWidget(
                            label: 'EMAIL',
                            hint: 'Enter Email',
                            isActive: active,
                            value: viewModel.recoveryEmail,
                            errorText: viewModel.recoveryEmailError,
                            onChanged: (v) => context
                                .read<AuthProvider>()
                                .updateRecoveryEmail(v),
                            onFocus: () => context
                                .read<AuthProvider>()
                                .setRecoveryFormActive(true),
                            onBlur: () => context
                                .read<AuthProvider>()
                                .validateRecoveryEmail(),
                            onSubmitted: () => context
                                .read<AuthProvider>()
                                .sendRecoveryLink(context),
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 24.h),

                          // ── Send Recovery Link button ──────────────
                          EmailSignupButtonWidget(
                            isLoading: viewModel.isLoading,
                            isActive: viewModel.isRecoveryFormValid,
                            width: double.infinity,
                            label: "Send Recovery Link",
                            onTap: () {
                              context.read<AuthProvider>().sendRecoveryLink(
                                context,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const OtpScreen(),
                                ),
                              );
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
