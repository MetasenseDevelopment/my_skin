import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../models/introduction_model.dart';

class IntroductionViewModel extends ChangeNotifier {
  final IntroductionData _data = IntroductionData(
    title: AppStrings.introductionTitle,
    subtitle: AppStrings.introductionSubtitle,
    description: AppStrings.introductionDescription,
    nextButton: AppStrings.letsGoButton,
  );

  IntroductionData get data => _data;
}
