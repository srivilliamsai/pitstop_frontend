// lib/widgets/fuel_station_card.dart
import 'package:flutter/material.dart';
import 'package:pitstop_frontend/screens/fuel_station_detail_page.dart';
import 'package:pitstop_frontend/theme/theme.dart';

class FuelStationCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final double rating;
  final String location;

  const FuelStationCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // CRITICAL FIX: Pass the station's data to the detail page.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FuelStationDetailPage(
              name: name,
              image: imagePath,
              rating: rating,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // IMPROVEMENT: Changed to an IconButton for better user interaction.
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Handle add to wishlist action
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // IMPROVEMENT: Using the app's theme for consistent text styling.
            Text(
              location,
              style: textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}