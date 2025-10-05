import 'package:flutter/material.dart';
import 'package:pitstop_frontend/widgets/service_icon.dart';
import 'package:pitstop_frontend/screens/service_pages.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore All Services"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
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
          ServiceIcon(
            title: "Hospital",
            iconPath: 'lib/assets/images/hospital_icon.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ServicePlaceholderPage(
                  title: "Nearby Hospitals",
                  providers: mockHospitals,
                ),
              ),
            ),
          ),
          ServiceIcon(
            title: "Pharmacy",
            iconPath: 'lib/assets/images/pharmacy_icon.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ServicePlaceholderPage(
                  title: "Pharmacies",
                  providers: mockPharmacies,
                ),
              ),
            ),
          ),
          ServiceIcon(
            title: "Supermarket",
            iconPath: 'lib/assets/images/supermarket_icon.png',
            onTap: () {
              // TODO: Create a `mockSupermarketProviders` list in service_pages.dart
            },
          ),
          ServiceIcon(
            title: "Oil",
            iconPath: 'lib/assets/images/oil_icon.png',
            onTap: () {
              // TODO: Create a `mockOilChangeProviders` list in service_pages.dart
            },
          ),
        ],
      ),
    );
  }
}