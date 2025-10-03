import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String stationName;
  final String distance;
  final double rating;

  const ServiceDetailsPage({
    super.key,
    required this.stationName,
    required this.distance,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stationName,
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 Map placeholder (can integrate Google Maps later)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/banner2.jpg",
                  fit: BoxFit.cover, height: 200, width: double.infinity),
            ),
            const SizedBox(height: 16),

            // Station info
            Text(stationName,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(distance,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(rating.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 20),

            // Price info
            const Text("Fuel Prices",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                title: const Text("Petrol"),
                trailing: Text("₹ 102/L",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade600)),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Diesel"),
                trailing: Text("₹ 89/L",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade600)),
              ),
            ),

            const SizedBox(height: 20),

            // Reviews
            const Text("User Reviews",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            _reviewTile("Rahul Sharma",
                "Quick service and fuel quality is good.", 4.5),
            _reviewTile("Anita Mehta",
                "Bit crowded during peak hours, but staff is helpful.", 4.0),
          ],
        ),
      ),
    );
  }

  Widget _reviewTile(String user, String comment, double stars) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(comment),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            Text(stars.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}