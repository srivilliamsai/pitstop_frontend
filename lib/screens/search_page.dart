import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pitstop_frontend/models/place.dart';
import 'package:pitstop_frontend/screens/details_page.dart';
import 'package:pitstop_frontend/theme/theme.dart';
// The old SearchableItem class is no longer needed

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Place> _allItems = _getSearchableData(); // Now uses Place model
  List<Place> _filteredItems = [];
  final List<String> _recentSearches = ["Petrol Pump", "Puncture Shop", "Hospital"];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = query.isEmpty
          ? []
          : _allItems.where((item) =>
              item.name.toLowerCase().contains(query) ||
              item.address.toLowerCase().contains(query)).toList();
    });
  }
  
  static List<Place> _getSearchableData() {
    return [
      FuelBunk(name: 'Shell Bunk', address: 'Madhavaram, Chennai', coordinates: const LatLng(13.1425, 80.2486)),
      FuelBunk(name: 'Indian Oil', address: 'Perambur, Chennai', coordinates: const LatLng(13.1075, 80.2331)),
      ServiceLocation(name: 'Puncture', address: 'Find nearby tyre shops', icon: Icons.car_repair, coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Towing', address: '24/7 roadside assistance', icon: Icons.fire_truck_outlined, coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Hospital', address: 'Emergency medical centers', icon: Icons.local_hospital, coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Pharmacy', address: 'Find medical stores', icon: Icons.medical_services, coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Supermarket', address: 'Groceries and supplies', icon: Icons.store, coordinates: const LatLng(13.0827, 80.2707)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search for services or fuel bunks...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.subtext),
          ),
        ),
      ),
      body: _searchController.text.isEmpty
          ? _buildInitialView()
          : _buildSearchResults(),
    );
  }

  Widget _buildInitialView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text("Recent Searches", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _recentSearches.map((term) => Chip(
            label: Text(term),
            avatar: const Icon(Icons.history, size: 16),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_filteredItems.isEmpty) return const Center(child: Text("No results found."));
    
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return ListTile(
          leading: Icon(item.icon, color: AppColors.primary),
          title: Text(item.name),
          subtitle: Text(item.address),
          onTap: () {
            // FIX: Pass the 'item' which is a 'Place' object
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(place: item)),
            );
          },
        );
      },
    );
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}