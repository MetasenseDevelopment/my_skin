import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../../view_models/questionaire_1_view_model.dart';
import 'questionaire_screen_2.dart';
import 'wigdets/questionaire_widget.dart';

class QuestionaireScreen1 extends StatelessWidget {
  const QuestionaireScreen1({super.key});

  static const List<String> _options = [
    AppStrings.q1Option1,
    AppStrings.q1Option2,
    AppStrings.q1Option3,
    AppStrings.q1Option4,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Questionaire1ViewModel>(
      builder: (context, viewModel, child) {
        return QuestionaireWidget(
          imagePath: AppImages.questionaire1,
          title: AppStrings.questionaire1Title,
          question: AppStrings.questionaire1Question,
          options: _options,
          selectedIndex: viewModel.selectedIndex,
          onOptionSelected: viewModel.setSelectedIndex,
          onNext: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuestionaireScreen2(),
              ),
            );
          },
          tiltColor: AppColors.darkRed,
          tiltAngle: 0.1, // Tilted right
        );
      },
    );
  }
}
