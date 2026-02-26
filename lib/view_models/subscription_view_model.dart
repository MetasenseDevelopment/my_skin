import 'package:flutter/material.dart';

enum SubscriptionPlan { yearly, weekly }

class SubscriptionViewModel extends ChangeNotifier {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.yearly;

  SubscriptionPlan get selectedPlan => _selectedPlan;

  bool get isYearlySelected => _selectedPlan == SubscriptionPlan.yearly;
  bool get isWeeklySelected => _selectedPlan == SubscriptionPlan.weekly;

  void selectPlan(SubscriptionPlan plan) {
    if (_selectedPlan == plan) return;
    _selectedPlan = plan;
    notifyListeners();
  }

  void subscribe() {
    // Handle subscription logic here
  }
}
