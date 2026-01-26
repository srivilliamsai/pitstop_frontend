import 'package:flutter/material.dart';
import 'package:pitstop_frontend/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // For LatLng

class AppProvider extends ChangeNotifier {
  // --- STATE: Fuel Prices ---
  // [STATE MANAGEMENT] Centralized business data
  final Map<String, double> _fuelPrices = {
    'Petrol': 102.63, 'Diesel': 94.24, 'Gas': 55.10, 'EV Charge': 22.50,
  };
  final Map<String, String> _fuelUnits = {
    'Petrol': '/litre', 'Diesel': '/litre', 'Gas': '/kg', 'EV Charge': '/kWh',
  };
  String _selectedFuelType = 'Petrol';

  // --- STATE: Bunks ---
  // [CLEAN CODE] Unifying data from HomePage and SearchPage
  final List<FuelBunk> _bunks = [
    FuelBunk(
      name: 'Indian Oil', 
      address: 'Perambur', 
      logoPath: 'lib/assets/images/indian_oil_logo.png', 
      imageGallery: ['lib/assets/images/banner1.jpg'],
      coordinates: const LatLng(13.1075, 80.2331),
      rating: 4.2
    ),
    FuelBunk(
      name: 'Shell Bunk', 
      address: 'Madhavaram', 
      logoPath: 'lib/assets/images/shell_logo.png', 
      imageGallery: ['lib/assets/images/banner2.jpg'],
      coordinates: const LatLng(13.1425, 80.2486),
      rating: 4.5
    ),
    FuelBunk(
      name: 'HP Petrol', 
      address: 'Anna Nagar', 
      logoPath: 'lib/assets/images/hp_logo.png', 
      imageGallery: ['lib/assets/images/banner1.jpg'],
      coordinates: const LatLng(13.0850, 80.2100), // Approx
      rating: 4.0
    ),
    FuelBunk(
      name: 'BP Bunk', 
      address: 'T. Nagar', 
      logoPath: 'lib/assets/images/bp_logo.png', 
      imageGallery: ['lib/assets/images/banner2.jpg'],
      coordinates: const LatLng(13.0400, 80.2300), // Approx
      rating: 4.1
    ),
  ];

  // --- Getters ---
  Map<String, double> get fuelPrices => _fuelPrices;
  Map<String, String> get fuelUnits => _fuelUnits;
  String get selectedFuelType => _selectedFuelType;
  List<FuelBunk> get bunks => _bunks;

  // --- Actions ---
  void setSelectedFuelType(String type) {
    if (_selectedFuelType != type) {
      _selectedFuelType = type;
      notifyListeners();
    }
  }

  // --- Existing Logic (kept for backward compatibility if needed) ---
  // State for multi-bunk comparison
  final List<String> _selectedBunkNames = ['Indian Oil'];
  List<String> get selectedBunkNames => _selectedBunkNames;

  void toggleBunkSelection(String bunkName) {
    if (_selectedBunkNames.contains(bunkName)) {
      if (_selectedBunkNames.length > 1) { // Prevent removing the last one
        _selectedBunkNames.remove(bunkName);
      }
    } else {
      _selectedBunkNames.add(bunkName);
    }
    notifyListeners(); // This tells widgets to rebuild
  }
}