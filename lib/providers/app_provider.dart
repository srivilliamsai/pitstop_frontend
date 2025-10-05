import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // State for multi-bunk comparison
  final List<String> _selectedBunks = ['Indian Oil'];
  List<String> get selectedBunks => _selectedBunks;

  void toggleBunkSelection(String bunkName) {
    if (_selectedBunks.contains(bunkName)) {
      if (_selectedBunks.length > 1) { // Prevent removing the last one
        _selectedBunks.remove(bunkName);
      }
    } else {
      _selectedBunks.add(bunkName);
    }
    notifyListeners(); // This tells widgets to rebuild
  }
}