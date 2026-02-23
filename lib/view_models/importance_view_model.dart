import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../models/importance_model.dart';

class ImportanceViewModel extends ChangeNotifier {
  final ImportanceData _data = ImportanceData(
    title: AppStrings.importanceTitle,
    mySkinText: AppStrings.importanceMySkin,
    subtitle: AppStrings.importanceSubtitle,
    footer: AppStrings.importanceFooter,
    backButton: AppStrings.backButton,
    nextButton: AppStrings.nextButton,
  );

  ImportanceData get data => _data;
}
