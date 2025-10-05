// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:pitstop_frontend/screens/fuel_dashboard_page.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import '../widgets/fuel_station_card.dart';
import '../widgets/service_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, this data would come from a provider or API.
    const double currentPetrolPrice = 102.75; // Example dynamic price for Chennai

    return Scaffold(
      body: _HomeContent(petrolPrice: currentPetrolPrice),
    );
  }
}

// This private widget keeps the HomePage code clean and organized.
class _HomeContent extends StatelessWidget {
  final double petrolPrice;
  const _HomeContent({required this.petrolPrice});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildPriceCompareCard(context, petrolPrice),
          const SizedBox(height: 24),
          _buildSectionTitle(context, "Our Services"),
          _buildServicesGrid(),
          const SizedBox(height: 24),
          _buildSectionTitle(context, "Bunk Around You"),
          _buildNearbyBunks(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('lib/assets/images/profile_avatar.png'),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
              const SizedBox(height: 2),
              const Text("Madhavaram, Chennai",
                  style: TextStyle(color: AppColors.subtext)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.notifications_none,
              color: AppColors.text, size: 28),
        ],
      ),
    );
  }

  Widget _buildPriceCompareCard(BuildContext context, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Petrol",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(
                    "₹${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FuelDashboardPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.compare_arrows),
                    SizedBox(width: 8),
                    Text("Compare Prices"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget _buildServicesGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ServiceIcon(
              title: "Puncture", iconPath: 'lib/assets/images/tyre.png'),
          const ServiceIcon(
              title: "Towing", iconPath: 'lib/assets/images/pickup.png'),
          const ServiceIcon(
              title: "Fuel", iconPath: 'lib/assets/images/fuel.png'),
          const ServiceIcon(
              title: "Oil Refill",
              iconPath: 'lib/assets/images/fuel_icon.png'),
        ],
      ),
    );
  }

  Widget _buildNearbyBunks(BuildContext context) {
    final stations = [
      {
        "image": 'lib/assets/images/banner2.jpg',
        "name": "Shell Petrol Bunk",
        "rating": 4.5,
        "location": "Madhavaram Milk Colony",
      },
      {
        "image": 'lib/assets/images/banner1.jpg',
        "name": "Indian Oil Pump",
        "rating": 4.2,
        "location": "Perambur",
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return FuelStationCard(
            imagePath: station['image'] as String,
            name: station['name'] as String,
            rating: station['rating'] as double,
            location: station['location'] as String,
          );
        },
      ),
    );
  }
}