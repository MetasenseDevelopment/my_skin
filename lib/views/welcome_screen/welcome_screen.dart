import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../core/consts/app_images.dart';
import '../../view_models/welcome_view_model.dart';
import '../../widgets/quote_widget.dart';
import '../user_info_screen/user_info_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      body: Consumer<WelcomeViewModel>(
        builder: (context, viewModel, child) {
          final data = viewModel.data;
          return SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  60.verticalSpace,
                  Text(
                    data.welcomeText,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: AppColors.black87,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppImages.mySkinLogo,
                    height: 345.h,
                    width: 272.w,
                  ),
                  20.verticalSpace,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.black54,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'Your Skin, ',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 24.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'Elevated.\n',
                          style: TextStyle(
                            fontFamily: AppFonts.playfairDisplay,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: AppColors.black87,
                            fontSize: 24.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'From ',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 24.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'Within.',
                          style: TextStyle(
                            fontFamily: AppFonts.playfairDisplay,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: AppColors.black87,
                            fontSize: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const QuoteWidget(),
                  28.5.verticalSpace,
                  Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.white, width: 4.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackShadow.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: AppColors.goldShadow,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: AppColors.goldBottom.withValues(alpha: 0.20),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UserInfoScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        data.buttonText,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.loginText,
                        style: TextStyle(
                          color: AppColors.black54,
                          fontSize: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          data.loginActionText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ],
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
