import 'package:flutter/material.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_navbar.dart';
import '../models/service_model.dart';

class HomePage extends StatelessWidget {
  final List<Service> services = [
    Service(
      title: 'Fuel Delivery',
      imagePath: 'lib/assets/images/fuel_icon.png',
      description: 'Get fuel delivered anywhere, anytime.',
    ),
    Service(
      title: 'Emergency Help',
      imagePath: 'lib/assets/images/fuel_icon.png',
      description: '24/7 roadside emergency assistance.',
    ),
    Service(
      title: 'Supermarket',
      imagePath: 'lib/assets/images/fuel_icon.png',
      description: 'Groceries and essentials at your doorstep.',
    ),
    Service(
      title: 'Nearby Hotels',
      imagePath: 'lib/assets/images/fuel_icon.png',
      description: 'Discover hotels near your location.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to PitStop',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const BannerCarousel(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Our Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: services.length,
                itemBuilder: (context, index) => ServiceCard(
                  service: services[index],
                  onTap: () {
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}