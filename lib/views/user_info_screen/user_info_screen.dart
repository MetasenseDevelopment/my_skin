import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_fonts.dart';
import '../../view_models/user_info_view_model.dart';
import 'widgets/name_field.dart';
import 'widgets/age_dropdown.dart';
import 'widgets/next_button.dart';
import 'widgets/image_carousel.dart';
import '../importance_screen/importance_screen.dart';
import '../../core/utils/widgets/glassy_app_bar.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassyAppBar(),
      backgroundColor: AppColors.white,
      body: Consumer<UserInfoViewModel>(
        builder: (context, viewModel, child) {
          final data = viewModel.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Auto-scrolling image carousel
                const ImageCarousel(),

                // Title
                Padding(
                  padding: EdgeInsets.fromLTRB(28.w, 32.h, 28.w, 0),
                  child: Text(
                    data.title,
                    style: TextStyle(
                      fontFamily: AppFonts.playfairDisplay,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black87,
                      height: 1.2,
                    ),
                  ),
                ),

                28.verticalSpace,

                // Name Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: NameField(
                    label: data.nameLabel,
                    hint: data.nameHint,
                    value: viewModel.name,
                    onChanged: viewModel.updateName,
                  ),
                ),

                16.verticalSpace,

                // Age Dropdown
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AgeDropdown(
                    label: data.ageLabel,
                    hint: data.ageHint,
                    selectedAge: viewModel.selectedAge,
                    ageOptions: data.ageOptions,
                    onSelected: viewModel.selectAge,
                  ),
                ),

                32.verticalSpace,

                // Next Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: NextButton(
                    text: data.buttonText,
                    isEnabled: viewModel.isFormValid,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ImportanceScreen(),
                        ),
                      );
                    },
                  ),
                ),

                40.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
