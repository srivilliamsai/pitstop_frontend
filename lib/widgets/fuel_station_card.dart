import 'package:flutter/material.dart';
import 'package:pitstop_frontend/screens/fuel_station_detail_page.dart';
import '../theme/theme.dart';

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
    return GestureDetector(
      onTap: () {
        // Pass the required data to the detail page
        Navigator.push(context, MaterialPageRoute(builder: (_) => FuelStationDetailPage(
          name: name,
          image: imagePath,
          rating: rating,
        )));
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
              ],
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(location, style: const TextStyle(color: AppColors.subtext, fontSize: 12)),
             const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}