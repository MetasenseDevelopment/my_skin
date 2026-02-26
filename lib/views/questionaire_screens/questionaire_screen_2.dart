import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../../view_models/questionaire_2_view_model.dart';
import 'questionaire_screen_3.dart';
import 'wigdets/questionaire_widget.dart';

class QuestionaireScreen2 extends StatelessWidget {
  const QuestionaireScreen2({super.key});

  static const List<String> _options = [
    AppStrings.q2Option1,
    AppStrings.q2Option2,
    AppStrings.q2Option3,
    AppStrings.q2Option4,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Questionaire2ViewModel>(
      builder: (context, viewModel, child) {
        return QuestionaireWidget(
          imagePath: AppImages.questionaire2,
          title: AppStrings.questionaire2Title,
          question: AppStrings.questionaire2Question,
          options: _options,
          selectedIndex: viewModel.selectedIndex,
          onOptionSelected: viewModel.setSelectedIndex,
          onNext: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuestionaireScreen3(),
              ),
            );
          },
          tiltColor: AppColors.yellowColor,
          tiltAngle: 0.1, // Tilted right as per explicit user edit
        );
      },
    );
  }
}
