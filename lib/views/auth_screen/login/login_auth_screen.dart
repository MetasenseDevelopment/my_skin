// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_icons.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/views/auth_screen/forgetpassword/password_recovery_screen.dart';
import 'package:my_skin/views/auth_screen/signup/signup_auth_screen.dart';
import 'package:my_skin/views/auth_screen/widgets/account_text_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/divider_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/email_signup_button_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/footer_text_widgets.dart';
import 'package:my_skin/views/auth_screen/widgets/social_button_widgets.dart';
import 'package:my_skin/widgets/custom_textform.dart';
import 'package:my_skin/widgets/rose_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, viewModel, child) {
          final bool active = viewModel.isLoginFormActive;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),

                      // ── Rose logo ──────────────────────────────────
                      RoseLogo(isActive: active),

                      SizedBox(height: 40.h),

                      Column(
                        children: [
                          // ── Email field ────────────────────────────
                          CustomTextformWidget(
                            label: AppStrings.emailLabel,
                            hint: AppStrings.emailHint,
                            isActive: active,
                            value: viewModel.loginEmail,
                            errorText: viewModel.loginEmailError,
                            onChanged: (v) => context
                                .read<AuthProvider>()
                                .updateLoginEmail(v),
                            onFocus: () => context
                                .read<AuthProvider>()
                                .setLoginFormActive(true),
                            onBlur: () => context
                                .read<AuthProvider>()
                                .validateLoginEmail(),
                            onSubmitted: () => context
                                .read<AuthProvider>()
                                .validateLoginEmail(),
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 12.h),

                          // ── Password field ─────────────────────────
                          CustomTextformWidget(
                            label: AppStrings.passwordLabel,
                            hint: AppStrings.passwordHint,
                            isActive: active,
                            value: viewModel.loginPassword,
                            errorText: viewModel.loginPasswordError,
                            isPassword: true,
                            isVisible: viewModel.isLoginPasswordVisible,
                            onChanged: (v) => context
                                .read<AuthProvider>()
                                .updateLoginPassword(v),
                            onFocus: () => context
                                .read<AuthProvider>()
                                .setLoginFormActive(true),
                            onBlur: () => context
                                .read<AuthProvider>()
                                .validateLoginPassword(),
                            onSubmitted: () =>
                                context.read<AuthProvider>().signInWithEmail(),
                            onToggleVisibility: () => context
                                .read<AuthProvider>()
                                .toggleLoginPasswordVisibility(),
                          ),

                          // ── Forgot password (shows after wrong attempt) ─
                          AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: viewModel.showForgotPassword
                                ? Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.h,
                                      right: 4.w,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PasswordRecoveryScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontFamily: AppFonts.lato,
                                            color: AppColors.accentYellow,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),

                          SizedBox(height: 20.h),

                          // ── Login button ───────────────────────────
                          EmailSignupButtonWidget(
                            isLoading: viewModel.isLoading,
                            isActive: viewModel.isLoginFormValid,
                            width: double.infinity,
                            label: AppStrings.logIn,
                            onTap: () =>
                                context.read<AuthProvider>().signInWithEmail(),
                          ),

                          SizedBox(height: 14.h),

                          // ── Don't have account ─────────────────────
                          AccountTextWidget(
                            title: AppStrings.dontHaveAccount,
                            actionText: AppStrings.signUp,
                            onTap: () {
                              context.read<AuthProvider>().resetLogin();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 28.h),
                          DividerWidget(),
                          SizedBox(height: 20.h),

                          // ── Google button ──────────────────────────
                          SocialButton(
                            width: double.infinity,
                            icon: Iconify(AppIcons.google, size: 24.sp),
                            label: AppStrings.signUpWithGoogle,
                            isLoading: viewModel.isLoading,
                            onTap: () => context
                                .read<AuthProvider>()
                                .continueWithGoogle(),
                          ),

                          SizedBox(height: 12.h),

                          // ── Apple button ───────────────────────────
                          SocialButton(
                            width: double.infinity,
                            icon: Iconify(AppIcons.apple, size: 24.sp),
                            label: AppStrings.signUpWithApple,
                            isLoading: viewModel.isLoading,
                            onTap: () => context
                                .read<AuthProvider>()
                                .continueWithApple(),
                          ),

                          SizedBox(height: 32.h),
                          FooterText(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
