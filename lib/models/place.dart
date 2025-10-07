import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Represents a user review for a place
class Review {
  final String author;
  final double rating;
  final String comment;
  const Review({required this.author, required this.rating, required this.comment});
}

class RecommendedProduct {
  final String name;
  final String imagePath;
  final double rating;
  final String price;
  const RecommendedProduct({required this.name, required this.imagePath, required this.rating, required this.price});
}

// Defines the types of action buttons available
enum PlaceAction { directions, call, save, bookFuel, website }

// Base abstract class for any searchable place in the app
abstract class Place {
  final String name;
  final String category;
  final String address;
  final double rating;
  final String reviewCount;
  final LatLng coordinates;
  final String logoPath;
  final List<String> imageGallery;
  final List<RecommendedProduct> recommendedProducts;
  final List<Review> reviews;

  Place({
    required this.name,
    required this.category,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.coordinates,
    required this.logoPath,
    required this.imageGallery,
    this.recommendedProducts = const [],
    this.reviews = const [],
  });

  List<PlaceAction> get actionButtons;
}

class FuelBunk extends Place {
  final Map<String, double> prices;
  final Map<String, List<double>> priceHistory;

  FuelBunk({
    required super.name,
    required super.address,
    required super.coordinates,
    required super.logoPath,
    super.rating = 4.7,
    super.reviewCount = "32k+ reviews",
    super.category = "Petrol Pump",
    this.prices = const {'Petrol': 102.63, 'Diesel': 94.24, 'Gas': 55.10},
    this.priceHistory = const {
      'Petrol': [102.5, 102.8, 102.6, 103.0, 102.9, 102.7, 102.6]
    },
    super.imageGallery = const [
      'lib/assets/images/shell_station.png', 'lib/assets/images/banner1.jpg', 'lib/assets/images/banner2.jpg',
      'lib/assets/images/shell_station.png', 'lib/assets/images/banner1.jpg', 'lib/assets/images/video_placeholder.png'
    ],
    super.reviews = const [
      Review(author: "Anjali", rating: 5.0, comment: "Very clean and efficient!"),
      Review(author: "Ben", rating: 4.0, comment: "Good fuel quality."),
      Review(author: "Charles", rating: 4.5, comment: "Convenient location."),
      Review(author: "Diya", rating: 5.0, comment: "My go-to petrol bunk."),
      Review(author: "Ethan", rating: 3.0, comment: "Air pressure machine was not working."),
      Review(author: "Fiona", rating: 4.0, comment: "Decent place for a quick refuel."),
      Review(author: "Gaurav", rating: 5.0, comment: "Accepts all forms of digital payment."),
      Review(author: "Hannah", rating: 4.0, comment: "Staff is helpful."),
      Review(author: "Irfan", rating: 5.0, comment: "Consistently good experience."),
      Review(author: "Jaya", rating: 4.0, comment: "Clean restrooms available."),
    ],
  });

  @override
  List<PlaceAction> get actionButtons => [PlaceAction.bookFuel, PlaceAction.directions, PlaceAction.save];
}

class ServiceLocation extends Place {
  final String operatingHours;

  ServiceLocation({
    required super.name,
    required super.address,
    required super.coordinates,
    required super.logoPath,
    required super.category,
    this.operatingHours = "Open 24 hours",
    // --- FIX: Added missing required parameters from Place ---
    super.rating = 4.5,
    super.reviewCount = "10k+ reviews",
    super.imageGallery = const [
      'lib/assets/images/emergency_banner.png', 'lib/assets/images/banner2.jpg',
      'lib/assets/images/emergency_banner.png', 'lib/assets/images/banner1.jpg', 'lib/assets/images/video_placeholder.png'
    ],
     super.reviews = const [
      Review(author: "Karthik", rating: 4.0, comment: "Quick and professional service."),
      Review(author: "Leela", rating: 5.0, comment: "Lifesaver! Arrived faster than expected."),
      Review(author: "Manoj", rating: 3.5, comment: "A bit expensive, but the service was good."),
      Review(author: "Nisha", rating: 5.0, comment: "The hospital staff were incredibly caring."),
      Review(author: "Omar", rating: 4.0, comment: "Good availability of medicines."),
      Review(author: "Priya", rating: 5.0, comment: "Excellent service, highly recommend."),
      Review(author: "Qamar", rating: 4.0, comment: "They had exactly what I was looking for."),
      Review(author: "Ravi", rating: 5.0, comment: "Very reliable and trustworthy team."),
      Review(author: "Sunita", rating: 4.0, comment: "The doctors are very experienced."),
      Review(author: "Tariq", rating: 5.0, comment: "Found all my groceries here."),
    ],
    // --------------------------------------------------------
  });

  @override
  List<PlaceAction> get actionButtons => [PlaceAction.directions, PlaceAction.call, PlaceAction.save];
}