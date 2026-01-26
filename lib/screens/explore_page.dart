import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pitstop_frontend/theme/theme.dart'; // Ensure this path is correct

class QuickService {
  final IconData icon;
  final String label;
  QuickService(this.icon, this.label);
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // --- CONSTANTS ---
  static const double _initialSheetSize = 0.4;
  static const double _maxSheetSize = 0.9;

  // --- CONTROLLERS & STATE ---
  final Completer<GoogleMapController> _mapController = Completer();
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  LocationData? _currentLocation;
  double _currentSheetSize = _initialSheetSize;
  double _mapBottomPadding = 0;

  final List<QuickService> _services = [
    QuickService(Icons.local_gas_station_rounded, "Fuel"),
    QuickService(Icons.car_repair_rounded, "Towing"),
    QuickService(Icons.battery_charging_full_rounded, "Battery"),
    QuickService(Icons.tire_repair_rounded, "Puncture"),
    QuickService(Icons.ev_station_rounded, "EV Charge"),
    QuickService(Icons.local_hospital_rounded, "Hospital"),
    QuickService(Icons.local_pharmacy_rounded, "Pharmacy"),
    QuickService(Icons.oil_barrel_rounded, "Oil"),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _searchFocusNode.addListener(_onSearchFocusChange);
    _sheetController.addListener(_updateStateFromSheet);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onSearchFocusChange);
    _sheetController.removeListener(_updateStateFromSheet);
    _sheetController.dispose();
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _updateStateFromSheet() {
    if (mounted) {
      setState(() {
        _currentSheetSize = _sheetController.size;
        _mapBottomPadding = MediaQuery.of(context).size.height * _currentSheetSize;
      });
    }
  }

  void _onSearchFocusChange() {
    if (_searchFocusNode.hasFocus) {
      _sheetController.animateTo(_maxSheetSize,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
    try {
      _currentLocation = await location.getLocation();
      if (_currentLocation?.latitude != null) {
        final c = await _mapController.future;
        c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          zoom: 15,
        )));
        if (mounted) setState(() {});
      }
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSearchActive = _searchFocusNode.hasFocus;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // --- FIX: Determine if the sheet is dragged up manually ---
    // Hides the button if the sheet is even slightly above its starting point.
    final bool isSheetDraggedUp = _currentSheetSize > _initialSheetSize + 0.01;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (c) {
              if (!_mapController.isCompleted) _mapController.complete(c);
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation != null
                  ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
                  : const LatLng(13.0827, 80.2707),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            // The padding correctly keeps the Google Logo visible, which is required.
            padding: EdgeInsets.only(bottom: _mapBottomPadding -20),
          ),
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: _initialSheetSize,
            minChildSize: 0.2,
            maxChildSize: _maxSheetSize,
            snap: true,
            snapSizes: const [_initialSheetSize, 0.6, _maxSheetSize],
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.9),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        _buildDragHandle(),
                        _buildSearchBar(isSearchActive, isDark),
                        _buildSectionTitle("Quick Services"),
                        _buildServiceGrid(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // --- FIX: Button is now hidden if search is active OR if the sheet is dragged up ---
          if (!isSearchActive && !isSheetDraggedUp) _buildFloatingNavButton(),
        ],
      ),
    );
  }

  Widget _buildFloatingNavButton() {
    return Positioned(
      bottom: _mapBottomPadding + 1,
      right: 16,
      child: FloatingActionButton(
        onPressed: _getCurrentLocation,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: const Icon(Icons.navigation_outlined, size: 28),
      ),
    );
  }

  Widget _buildDragHandle() => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  Widget _buildSearchBar(bool isSearchActive, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: "Search places or services",
          hintStyle: TextStyle(
              color: isDark ? Colors.white70 : Colors.grey.shade600),
          prefixIcon: Icon(Icons.search,
              color: isDark ? Colors.white70 : AppColors.subtext),
          suffixIcon: isSearchActive
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    _searchFocusNode.unfocus();
                    _sheetController.animateTo(_initialSheetSize,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  child: Icon(Icons.close,
                      color: isDark ? Colors.white70 : AppColors.subtext),
                )
              : Icon(Icons.mic,
                  color: isDark ? Colors.white70 : AppColors.subtext),
          filled: true,
          fillColor:
              isDark ? Colors.grey.shade900.withOpacity(0.8) : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      );

  Widget _buildServiceGrid() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: _services.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemBuilder: (context, i) => _buildServiceIcon(_services[i]),
      );

  Widget _buildServiceIcon(QuickService s) => InkWell(
        onTap: () => debugPrint("Tapped ${s.label}"),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(s.icon, color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 8),
            Text(s.label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.text)),
          ],
        ),
      );
}