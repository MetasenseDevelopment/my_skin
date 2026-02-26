// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:my_skin/core/consts/app_icons.dart';
import 'package:my_skin/core/consts/app_strings.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/views/auth_screen/signup/signup_auth_screen.dart';
import 'package:my_skin/views/auth_screen/widgets/account_text_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/divider_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/email_signup_button_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/footer_text_widgets.dart';
import 'package:my_skin/views/auth_screen/widgets/skin_widget.dart';
import 'package:my_skin/views/auth_screen/widgets/social_button_widgets.dart';
import 'package:my_skin/views/finalize_screen/finalizes_screen.dart';
import 'package:provider/provider.dart';

class WelcomeSession extends StatelessWidget {
  const WelcomeSession({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              MySkinText(),
              SizedBox(height: 52.h),
              EmailSignupButtonWidget(
                isLoading: auth.isLoading,
                onTap: () => context.read<AuthProvider>().signUpWithEmail(),
              ),
              SizedBox(height: 14.h),
              AccountTextWidget(
                title: AppStrings.alreadyHaveAccount,
                actionText: "Log In",
                onTap: () {
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
              SocialButton(
                icon: Iconify(AppIcons.google, size: 24.sp),
                label: AppStrings.signUpWithGoogle,
                isLoading: auth.isLoading,
                onTap: () => context.read<AuthProvider>().continueWithGoogle(),
              ),
              SizedBox(height: 12.h),
              SocialButton(
                icon: Iconify(AppIcons.apple, size: 24.sp),
                label: AppStrings.signUpWithApple,
                isLoading: auth.isLoading,
                onTap: () => context.read<AuthProvider>().continueWithApple(),
              ),
              SizedBox(height: 32.h),
              FooterText(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
