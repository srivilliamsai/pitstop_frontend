import 'package:flutter/material.dart'; // <-- FIX: Added this import
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecommendedProduct {
  final String name;
  final String imagePath;
  final double rating;
  final String price;

  // FIX: Added 'const' to the constructor
  const RecommendedProduct({
    required this.name, 
    required this.imagePath, 
    required this.rating, 
    required this.price
  });
}

abstract class Place {
  final String name;
  final String category;
  final String address;
  final double rating;
  final String reviewCount;
  final LatLng coordinates;
  final IconData icon;
  final List<String> imageGallery;
  final List<RecommendedProduct> recommendedProducts;

  Place({
    required this.name,
    required this.category,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.coordinates,
    required this.icon,
    required this.imageGallery,
    required this.recommendedProducts,
  });
}

class FuelBunk extends Place {
  FuelBunk({
    required super.name,
    required super.address,
    required super.coordinates,
    super.rating = 4.7,
    super.reviewCount = "32k+ reviews",
    super.icon = Icons.local_gas_station,
    super.category = "Fuel Station",
    super.imageGallery = const ['lib/assets/images/shell_station.png'],
    super.recommendedProducts = const [
      RecommendedProduct(name: "RACEMAX SCOOTER 4T", imagePath: 'lib/assets/images/engine_oil.png', rating: 4.7, price: "50.99")
    ]
  });
}

class ServiceLocation extends Place {
  ServiceLocation({
    required super.name,
    required super.address,
    required super.coordinates,
    required super.icon,
    super.rating = 4.5,
    super.reviewCount = "10k+ reviews",
    super.category = "Service",
    super.imageGallery = const ['lib/assets/images/emergency_banner.png'],
    super.recommendedProducts = const []
  });
}