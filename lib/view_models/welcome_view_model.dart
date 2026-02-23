import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../models/welcome_model.dart';

class WelcomeViewModel extends ChangeNotifier {
  WelcomeData _data = WelcomeData(
    welcomeText: AppStrings.welcomeText,
    title: AppStrings.appTitle,
    subtitleLine1: AppStrings.subtitleSkin + AppStrings.subtitleElevated,
    subtitleLine2: AppStrings.subtitleFrom + AppStrings.subtitleWithin,
    quotes: AppStrings.quotes,
    buttonText: AppStrings.beginJourney,
    loginText: AppStrings.haveAccount,
    loginActionText: AppStrings.logIn,
  );

  WelcomeData get data => _data;

  void updateData(WelcomeData newData) {
    _data = newData;
    notifyListeners();
  }
}
