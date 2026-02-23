import 'package:flutter/material.dart';
import '../core/consts/app_strings.dart';
import '../models/user_info_model.dart';

class UserInfoViewModel extends ChangeNotifier {
  final UserInfoData _data = UserInfoData(
    title: AppStrings.userInfoTitle,
    nameLabel: AppStrings.nameLabel,
    nameHint: AppStrings.nameHint,
    ageLabel: AppStrings.ageLabel,
    ageHint: AppStrings.ageHint,
    buttonText: AppStrings.nextButton,
    ageOptions: AppStrings.ageOptions,
  );

  String _name = '';
  String? _selectedAge;

  UserInfoData get data => _data;
  String get name => _name;
  String? get selectedAge => _selectedAge;
  bool get isFormValid => _name.trim().isNotEmpty && _selectedAge != null;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void selectAge(String age) {
    _selectedAge = age;
    notifyListeners();
  }
}
