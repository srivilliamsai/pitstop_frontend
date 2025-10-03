import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../theme/theme.dart';

// Import types; the plugin supports Android/iOS/Web.
// We'll avoid rendering it on macOS/desktop.
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  final String orderId;
  const OrderTrackingPage({super.key, required this.orderId});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(12.9716, 77.5946); // Bengaluru
  LatLng _destination = const LatLng(12.9352, 77.6245);     // Dummy dest
  bool _hasLocationPermission = false;

  final Location _location = Location();

  bool get _mapsSupported =>
      kIsWeb || Platform.isAndroid || Platform.isIOS;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      setState(() => _hasLocationPermission = true);

      final loc = await _location.getLocation();
      if (loc.latitude != null && loc.longitude != null) {
        setState(() {
          _currentPosition = LatLng(loc.latitude!, loc.longitude!);
        });

        if (_mapController != null) {
          await _mapController!.animateCamera(
            CameraUpdate.newLatLng(_currentPosition),
          );
        }
      }
    } catch (_) {
      // keep quiet; show default location
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.orderId}'),
      ),
      body: Column(
        children: [
          // Map / Placeholder
          SizedBox(
            height: 280,
            child: _mapsSupported
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition,
                      zoom: 14.5,
                    ),
                    myLocationEnabled: _hasLocationPermission,
                    myLocationButtonEnabled: true,
                    onMapCreated: (c) => _mapController = c,
                    markers: {
                      Marker(
                        markerId: const MarkerId('current'),
                        position: _currentPosition,
                      ),
                      Marker(
                        markerId: const MarkerId('destination'),
                        position: _destination,
                      ),
                    },
                  )
                : _DesktopMapPlaceholder(current: _currentPosition, dest: _destination),
          ),

          // ETA / Status Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.border),
              ),
              child: ListTile(
                leading: const Icon(Icons.timer, color: AppColors.primary),
                title: const Text(
                  'Arriving in 15–20 mins',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text('Your rider is on the way'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {/* track live… */},
                  child: const Text('Track'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopMapPlaceholder extends StatelessWidget {
  final LatLng current;
  final LatLng dest;

  const _DesktopMapPlaceholder({required this.current, required this.dest});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map, size: 48, color: AppColors.primary),
          const SizedBox(height: 8),
          const Text(
            'Live map preview not available on macOS.\nRun on iOS/Android/Web to see Google Maps.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'From: ${current.latitude.toStringAsFixed(4)}, ${current.longitude.toStringAsFixed(4)}\n'
            'To:   ${dest.latitude.toStringAsFixed(4)}, ${dest.longitude.toStringAsFixed(4)}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.subtext, fontSize: 12),
          ),
        ],
      ),
    );
  }
}