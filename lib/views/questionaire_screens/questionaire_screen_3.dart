import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/consts/app_colors.dart';
import '../../core/consts/app_images.dart';
import '../../core/consts/app_strings.dart';
import '../../view_models/questionaire_3_view_model.dart';
import '../medics_screen/medics_screen.dart';
import 'wigdets/questionaire_widget.dart';

class QuestionaireScreen3 extends StatelessWidget {
  const QuestionaireScreen3({super.key});

  static const List<String> _options = [
    AppStrings.q3Option1,
    AppStrings.q3Option2,
    AppStrings.q3Option3,
    AppStrings.q3Option4,
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Questionaire3ViewModel>(
      builder: (context, viewModel, child) {
        return QuestionaireWidget(
          imagePath: AppImages.questionaire3,
          title: AppStrings.questionaire3Title,
          question: AppStrings.questionaire3Question,
          options: _options,
          selectedIndex: viewModel.selectedIndex,
          onOptionSelected: viewModel.setSelectedIndex,
          onNext: () {
            // Action for submitting or pointing to next section
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedicsScreen()),
            );
          },
          tiltColor: AppColors.accentYellow,
          tiltAngle: 0.1, // Tilted right
        );
      },
    );
  }
}
