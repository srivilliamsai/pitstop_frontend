import 'package:flutter/material.dart';
import 'package:pitstop_frontend/screens/fuel_dashboard_page.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/widgets/fuel_station_card.dart';
import 'package:pitstop_frontend/widgets/service_icon.dart';
import 'package:pitstop_frontend/screens/service_pages.dart';
import 'package:pitstop_frontend/widgets/emergency_sos_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            const EmergencySosButton(),
            const SizedBox(height: 24),
            _buildPriceCompareCard(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "Our Services"),
            _buildServicesGrid(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "Bunk Around You"),
            _buildNearbyBunks(context),
          ],
        ),
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
              Text("Your Location", style: Theme.of(context).textTheme.bodySmall),
              const Text("Madhavaram, Chennai",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: AppColors.text, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCompareCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: const Color(0xFFFFF0F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Petrol",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("₹102.75",
                      style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FuelDashboardPage())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Compare Prices"),
              ),
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

  Widget _buildServicesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ServiceIcon(
            title: "Fuel",
            iconPath: 'lib/assets/images/fuel.png',
            onTap: () {
              // TODO: Create a `mockFuelProviders` list in service_pages.dart
            },
          ),
          ServiceIcon(
            title: "Puncture",
            iconPath: 'lib/assets/images/tyre.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ServicePlaceholderPage(
                  title: "Puncture Shops",
                  providers: mockPunctureShops,
                ),
              ),
            ),
          ),
          ServiceIcon(
            title: "Towing",
            iconPath: 'lib/assets/images/pickup.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ServicePlaceholderPage(
                  title: "Towing Services",
                  providers: mockTowingServices,
                ),
              ),
            ),
          ),
          ServiceIcon(
            title: "EV Charge",
            iconPath: 'lib/assets/images/ev_charge_icon.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ServicePlaceholderPage(
                  title: "EV Charging Stations",
                  providers: mockEvStations,
                ),
              ),
            ),
          ),
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
        "location": "Madhavaram"
      },
      {
        "image": 'lib/assets/images/banner1.jpg',
        "name": "Indian Oil Pump",
        "rating": 4.2,
        "location": "Perambur"
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