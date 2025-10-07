import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pitstop_frontend/models/place.dart';
import 'package:pitstop_frontend/screens/details_page.dart';
import 'package:pitstop_frontend/theme/theme.dart'; // <-- FIX: Added missing theme import

// The invalid 'package.dart' import has been removed.

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Place> _allItems = _getSearchableData();
  List<Place> _filteredItems = [];
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  
  final List<String> _categories = ["Petrol", "Puncture", "Towing", "Hospital", "Pharmacy", "EV Charge"];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _updateMarkers();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) =>
          item.name.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query)).toList();
      _updateMarkers();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = _selectedCategory == category ? null : category;
      _searchController.text = _selectedCategory ?? "";
    });
  }

  void _updateMarkers() {
    _markers = _filteredItems.map((place) => Marker(
      markerId: MarkerId(place.name),
      position: place.coordinates,
      infoWindow: InfoWindow(title: place.name, snippet: place.address),
      onTap: () => _onMarkerTapped(place),
    )).toSet();
  }
  
  void _onMarkerTapped(Place place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: _buildPlaceListItem(place, isModal: true)
      ),
    );
  }

  static List<Place> _getSearchableData() {
    return [
      FuelBunk(name: 'Shell Bunk', address: 'Madhavaram, Chennai', coordinates: const LatLng(13.1425, 80.2486), logoPath: 'lib/assets/images/shell_logo.png'),
      FuelBunk(name: 'Indian Oil', address: 'Perambur, Chennai', coordinates: const LatLng(13.1075, 80.2331), logoPath: 'lib/assets/images/indian_oil_logo.png', prices: {'Petrol': 102.63, 'Diesel': 94.24, 'Gas': 55.10}),
      ServiceLocation(name: 'Pro Tyre Shop', address: 'Find nearby tyre shops', category: "Puncture", logoPath: 'lib/assets/images/tyre_shop_logo.png', coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Quick Tow', address: '24/7 roadside assistance', category: "Towing", logoPath: 'lib/assets/images/towing_logo.png', coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'Apollo Hospital', address: 'Emergency medical centers', category: "Hospital", logoPath: 'lib/assets/images/hospital_logo.png', coordinates: const LatLng(13.0827, 80.2707)),
      ServiceLocation(name: 'MedPlus Pharmacy', address: 'Find medical stores', category: "Pharmacy", logoPath: 'lib/assets/images/pharmacy_logo.png', coordinates: const LatLng(13.0827, 80.2707)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(target: LatLng(13.0827, 80.2707), zoom: 12),
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
          ),
          _buildSearchUI(),
          _buildResultsSheet(),
        ],
      ),
    );
  }

  Widget _buildSearchUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search services or places...",
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  suffixIcon: IconButton(icon: const Icon(Icons.close), onPressed: () {
                    _searchController.clear();
                    setState(() { _selectedCategory = null; });
                  }),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _categories.map((cat) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: _selectedCategory == cat,
                    onSelected: (selected) => _onCategorySelected(cat),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildResultsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 4))]
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 4, width: 40,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),
              Expanded(
                child: _filteredItems.isEmpty 
                  ? const Center(child: Text("No results to display."))
                  : ListView.builder(
                    controller: scrollController,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) => _buildPlaceListItem(_filteredItems[index]),
                  ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceListItem(Place place, {bool isModal = false}) {
    return ListTile(
      leading: Image.asset(place.logoPath, width: 40, height: 40),
      title: Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(place.category),
      onTap: () {
        if (isModal) Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(place: place)));
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: place.actionButtons.map((action) => _buildActionButton(action)).toList(),
      ),
    );
  }
  
  Widget _buildActionButton(PlaceAction action) {
    IconData icon;
    switch(action) {
      case PlaceAction.directions: icon = Icons.directions; break;
      case PlaceAction.call: icon = Icons.call; break;
      case PlaceAction.save: icon = Icons.bookmark_border; break;
      case PlaceAction.bookFuel: icon = Icons.local_gas_station; break;
      case PlaceAction.website: icon = Icons.web; break;
    }
    return IconButton(icon: Icon(icon, color: AppColors.primary), onPressed: (){});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}