import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _selectedBrand = 'Indian Oil';
  String get selectedBrand => _selectedBrand;

  void selectBrand(String brand) {
    if (_selectedBrand != brand) {
      _selectedBrand = brand;
      notifyListeners();
    }
  }
}