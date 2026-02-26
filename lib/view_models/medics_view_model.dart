import 'package:flutter/material.dart';

class MedicsViewModel extends ChangeNotifier {
  final List<String> _products = [
    'Hyaluronic acid',
    'Glycolic Acid',
    'Retinol',
    'Face Oil',
    'SPF 50+',
    'Vitamin D',
    'Niacinamide',
    'Azelaic Acid',
    'Ceramides',
    'Adapalene',
    'Tretinoin',
  ];

  List<String> get products => _products;

  final Set<String> _selectedProducts = {};
  Set<String> get selectedProducts => _selectedProducts;

  bool _isAnalyzing = false;
  bool get isAnalyzing => _isAnalyzing;

  void toggleProduct(String product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
    } else {
      _selectedProducts.add(product);
    }
    notifyListeners();
  }

  void addCustomProduct(String product) {
    if (product.trim().isNotEmpty && !_products.contains(product.trim())) {
      _products.insert(0, product.trim());
      _selectedProducts.add(product.trim());
      notifyListeners();
    }
  }

  bool _isAddingCustom = false;
  bool get isAddingCustom => _isAddingCustom;

  void setIsAddingCustom(bool value) {
    if (_isAddingCustom != value) {
      _isAddingCustom = value;
      notifyListeners();
    }
  }

  Future<void> startAnalysis(VoidCallback onComplete) async {
    _isAnalyzing = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));

    _isAnalyzing = false;
    notifyListeners();
    onComplete();
  }
}
