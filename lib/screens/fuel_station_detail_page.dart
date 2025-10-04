import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FuelStationDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final double rating;

  const FuelStationDetailPage({
    Key? key,
    required this.name,
    required this.image,
    required this.rating,
  }) : super(key: key);

  @override
  State<FuelStationDetailPage> createState() => _FuelStationDetailPageState();
}

class _FuelStationDetailPageState extends State<FuelStationDetailPage> {
  late GoogleMapController _mapController;
  final LatLng _stationLocation = const LatLng(13.0827, 80.2707); // Default: Chennai
  final LatLng _userLocation = const LatLng(13.05, 80.25); // Dummy user location

  /// 🔗 Opens Google Maps
  Future<void> _openMaps(String query) async {
    final Uri mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    }
  }

  /// 🗺 Initializes map controller
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 🖼 Station Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // 🌟 Station Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black87),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(widget.rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 💰 Price Comparison
              const Text(
                "Today's Price Comparison",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _priceCard(
                brand: "Indian Oil",
                petrolPrice: 99.1,
                dieselPrice: 90.3,
                gasPrice: 65.4,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 12),
              _priceCard(
                brand: "Shell Bunk",
                petrolPrice: 99.4,
                dieselPrice: 91.2,
                gasPrice: 66.2,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 24),

              // 📍 Map Section
              const Text(
                "Nearby Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // 🗺 Embedded Map
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 250,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _stationLocation,
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('station'),
                        position: _stationLocation,
                        infoWindow: InfoWindow(title: widget.name),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure),
                      ),
                      Marker(
                        markerId: const MarkerId('user'),
                        position: _userLocation,
                        infoWindow: const InfoWindow(title: "You"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),

          // 🧭 Floating “Get Directions” button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () => _openMaps(widget.name),
              backgroundColor: Colors.blueAccent,
              label: const Text(
                "Get Directions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.navigation),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCard({
    required String brand,
    required double petrolPrice,
    required double dieselPrice,
    required double gasPrice,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brand,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: color),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _priceTag("Petrol", petrolPrice, Colors.green),
                _priceTag("Diesel", dieselPrice, Colors.orange),
                _priceTag("Gas", gasPrice, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceTag(String label, double price, Color color) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w500, color: color)),
        const SizedBox(height: 4),
        Text(
          "₹${price.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}