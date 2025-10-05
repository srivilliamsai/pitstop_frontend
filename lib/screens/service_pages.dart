import 'package:flutter/material.dart';
import 'package:pitstop_frontend/models/service_provider_model.dart';
import 'package:pitstop_frontend/theme/theme.dart';

/// Generic placeholder page for displaying different service types.
class ServicePlaceholderPage extends StatelessWidget {
  final String title;
  final List<ServiceProvider> providers;

  const ServicePlaceholderPage({
    super.key,
    required this.title,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: AppColors.card,
            child: ListTile(
              leading: Image.asset(
                provider.imageUrl,
                width: 40,
                height: 40,
              ),
              title: Text(provider.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(provider.address),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(provider.rating.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Example mock data lists made public (underscore removed)
final List<ServiceProvider> mockPunctureShops = [
  ServiceProvider(
    name: "Pitstop Puncture Shop",
    address: "Adyar, Chennai",
    rating: 4.8,
    imageUrl: "lib/assets/images/puncture_icon.png",
  ),
  ServiceProvider(
    name: "Tyre Fix Chennai",
    address: "Velachery, Chennai",
    rating: 4.5,
    imageUrl: "lib/assets/images/puncture_icon.png",
  ),
];

final List<ServiceProvider> mockTowingServices = [
  ServiceProvider(
    name: "24/7 Roadside Assistance",
    address: "Velachery, Chennai",
    rating: 4.9,
    imageUrl: "lib/assets/images/pickup.png",
  ),
  ServiceProvider(
    name: "Quick Tow Chennai",
    address: "Guindy, Chennai",
    rating: 4.6,
    imageUrl: "lib/assets/images/pickup.png",
  ),
];

final List<ServiceProvider> mockEvStations = [
  ServiceProvider(
    name: "Tata Power EV Charge",
    address: "OMR Food Street",
    rating: 4.7,
    imageUrl: "lib/assets/images/ev_charge_icon.png",
  ),
  ServiceProvider(
    name: "Ather Grid",
    address: "Nungambakkam, Chennai",
    rating: 4.8,
    imageUrl: "lib/assets/images/ev_charge_icon.png",
  ),
];

final List<ServiceProvider> mockHospitals = [
  ServiceProvider(
    name: "Apollo Hospital",
    address: "Greams Road, Chennai",
    rating: 4.9,
    imageUrl: "lib/assets/images/hospital_icon.png",
  ),
  ServiceProvider(
    name: "Fortis Malar Hospital",
    address: "Adyar, Chennai",
    rating: 4.7,
    imageUrl: "lib/assets/images/hospital_icon.png",
  ),
];

final List<ServiceProvider> mockPharmacies = [
  ServiceProvider(
    name: "Apollo Pharmacy",
    address: "Besant Nagar, Chennai",
    rating: 4.5,
    imageUrl: "lib/assets/images/pharmacy_icon.png",
  ),
  ServiceProvider(
    name: "MedPlus",
    address: "Ashok Nagar, Chennai",
    rating: 4.4,
    imageUrl: "lib/assets/images/pharmacy_icon.png",
  ),
];