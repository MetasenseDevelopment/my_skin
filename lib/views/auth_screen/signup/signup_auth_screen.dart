// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_icons.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/views/auth_screen/login/login_auth_screen.dart';
import 'package:my_skin/views/auth_screen/widgets/account_text_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/divider_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/email_signup_button_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/footer_text_widgets.dart';
import 'package:my_skin/views/auth_screen/widgets/social_button_widgets.dart';
import 'package:my_skin/widgets/custom_textform.dart';
import 'package:my_skin/widgets/rose_widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<AuthProvider>(
        builder: (context, viewModel, child) {
          final bool active = viewModel.isSignupFormActive;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                          value: viewModel.signupEmail,
                          errorText: viewModel.signupEmailError,
                          onChanged: (v) =>
                              context.read<AuthProvider>().updateSignupEmail(v),
                          onFocus: () => context
                              .read<AuthProvider>()
                              .setSignupFormActive(true),
                          onBlur: () => context
                              .read<AuthProvider>()
                              .validateSignupEmail(),
                          onSubmitted: () => context
                              .read<AuthProvider>()
                              .validateSignupEmail(),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 12.h),

                        // ── Password field ─────────────────────────
                        CustomTextformWidget(
                          label: AppStrings.passwordLabel,
                          hint: AppStrings.passwordHint,
                          isActive: active,
                          value: viewModel.signupPassword,
                          errorText: viewModel.signupPasswordError,
                          isPassword: true,
                          isVisible: viewModel.isSignupPasswordVisible,
                          onChanged: (v) => context
                              .read<AuthProvider>()
                              .updateSignupPassword(v),
                          onFocus: () => context
                              .read<AuthProvider>()
                              .setSignupFormActive(true),
                          onBlur: () => context
                              .read<AuthProvider>()
                              .validateSignupPassword(),
                          onSubmitted: () => context
                              .read<AuthProvider>()
                              .validateSignupPassword(),
                          onToggleVisibility: () => context
                              .read<AuthProvider>()
                              .toggleSignupPasswordVisibility(),
                        ),

                        // ── Password hint ──────────────────────────
                        if (active &&
                            viewModel.signupPassword.isNotEmpty &&
                            viewModel.signupPasswordError == null)
                          Padding(
                            padding: EdgeInsets.only(top: 6.h, left: 4.w),
                            child: Row(
                              children: [
                                Text(
                                  '* Password can be any 7 characters',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black54,
                                    fontFamily: AppFonts.lato,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 12.h),

                        // ── Confirm Password field ─────────────────
                        CustomTextformWidget(
                          label: AppStrings.confirmPasswordLabel,
                          hint: AppStrings.confirmPasswordHint,
                          isActive: active,
                          value: viewModel.signupConfirmPassword,
                          errorText: viewModel.signupConfirmPasswordError,
                          isPassword: true,
                          isVisible: viewModel.isSignupConfirmPasswordVisible,
                          onChanged: (v) => context
                              .read<AuthProvider>()
                              .updateSignupConfirmPassword(v),
                          onFocus: () => context
                              .read<AuthProvider>()
                              .setSignupFormActive(true),
                          onBlur: () => context
                              .read<AuthProvider>()
                              .validateSignupConfirmPassword(),
                          onSubmitted: () =>
                              context.read<AuthProvider>().signUpWithEmail(),
                          onToggleVisibility: () => context
                              .read<AuthProvider>()
                              .toggleSignupConfirmPasswordVisibility(),
                        ),

                        SizedBox(height: 20.h),

                        // ── Sign Up button ─────────────────────────
                        EmailSignupButtonWidget(
                          isLoading: viewModel.isLoading,
                          isActive: viewModel.isSignupFormValid,
                          width: double.infinity,
                          label: AppStrings.signUp,
                          onTap: () =>
                              context.read<AuthProvider>().signUpWithEmail(),
                        ),

                        SizedBox(height: 14.h),

                        // ── Already have account ───────────────────
                        AccountTextWidget(
                          title: AppStrings.alreadyHaveAccount,
                          actionText: AppStrings.logIn,
                          onTap: () {
                            context.read<AuthProvider>().resetSignup();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
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
                          onTap: () =>
                              context.read<AuthProvider>().continueWithGoogle(),
                        ),

                        SizedBox(height: 12.h),

                        // ── Apple button ───────────────────────────
                        SocialButton(
                          width: double.infinity,
                          icon: Iconify(AppIcons.apple, size: 24.sp),
                          label: AppStrings.signUpWithApple,
                          isLoading: viewModel.isLoading,
                          onTap: () =>
                              context.read<AuthProvider>().continueWithApple(),
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
          );
        },
      ),
    );
  }
}
