import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // [STATE MANAGEMENT]
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/widgets/fuel_station_card.dart';
import 'package:pitstop_frontend/screens/service_pages.dart';
import 'package:pitstop_frontend/screens/search_page.dart';
import 'package:pitstop_frontend/screens/fuel_station_detail_page.dart';
import 'package:pitstop_frontend/models/place.dart'; // [CLEAN CODE] Use centralized model
import 'package:pitstop_frontend/providers/app_provider.dart'; // [STATE MANAGEMENT]

// [CLEAN CODE] Removed duplicate FuelBunk class definition

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // [STATE MANAGEMENT] Data moved to AppProvider

  // [STABILITY FIX] Nullable types to prevent crash if data is empty
  FuelBunk? _selectedBunk1;
  FuelBunk? _selectedBunk2;
  int _selectedBrandIndex = 0;

  @override
  void initState() {
    super.initState();
    // [STATE MANAGEMENT] Initialize local state from Provider data
    // We use post frame callback or listen:false to access provider in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppProvider>(context, listen: false);
      final bunks = provider.bunks;
      
      // [STABILITY FIX] Check list length before accessing indices
      if (bunks.isNotEmpty) {
        setState(() {
           _selectedBunk1 = bunks[0];
           // If we have at least 2, use the second one, else reuse the first
           _selectedBunk2 = bunks.length > 1 ? bunks[1] : bunks[0]; 
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // [STATE MANAGEMENT] Watch for changes in AppProvider
    final provider = Provider.of<AppProvider>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildFuelFinder(context, provider),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "Our Services", showMore: true),
            _buildServicesGrid(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "${provider.bunks.length} Bunk Around You", showMore: true),
            _buildNearbyBunks(context, provider),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Methods ---
  Widget _buildFuelFinder(BuildContext context, AppProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildFuelTypeDropdown(provider), 
              _buildFuelPriceDisplay(provider)
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.subtext),
                  const SizedBox(width: 8),
                  Text("Search services or fuel bunks...", style: TextStyle(color: AppColors.subtext, fontSize: 16)),
                  const Spacer(),
                  const Icon(Icons.filter_list, color: AppColors.subtext),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildBrandFilters(),
          const SizedBox(height: 16),
          _buildComparisonCard(provider),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(AppProvider provider) {
    // [STABILITY FIX] Handle potential empty list from provider
    if (provider.bunks.isEmpty) return const SizedBox(); 

    List<FuelBunk> availableBunksFor1 = provider.bunks.where((b) => b != _selectedBunk2).toList();
    List<FuelBunk> availableBunksFor2 = provider.bunks.where((b) => b != _selectedBunk1).toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(colors: [Color(0xFFEF5350), Color(0xFFE57373)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bunkSelector(_selectedBunk1, availableBunksFor1, (newBunk) {
                  if (newBunk != null) setState(() => _selectedBunk1 = newBunk);
                }),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Colors.white, size: 32),
                  onPressed: () => setState(() {
                    final temp = _selectedBunk1;
                    _selectedBunk1 = _selectedBunk2;
                    _selectedBunk2 = temp;
                  }),
                ),
                _bunkSelector(_selectedBunk2, availableBunksFor2, (newBunk) {
                  if (newBunk != null) setState(() => _selectedBunk2 = newBunk);
                }),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primary),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Compare Prices"), SizedBox(width: 8), Icon(Icons.arrow_forward)],
              ),
            )
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
            radius: 20,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Location", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.subtext)),
              const Row(
                children: [
                  Text("Madhavaram Milk Co...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Icon(Icons.keyboard_arrow_down, color: AppColors.text),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.text, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFuelPriceDisplay(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Text(
        // [STATE MANAGEMENT] Use data from provider
        "₹${provider.fuelPrices[provider.selectedFuelType]?.toStringAsFixed(2)} ${provider.fuelUnits[provider.selectedFuelType] ?? ''}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.text),
      ),
    );
  }

  Widget _buildFuelTypeDropdown(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        value: provider.selectedFuelType,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        borderRadius: BorderRadius.circular(12),
        items: provider.fuelPrices.keys.map((fuel) => DropdownMenuItem(value: fuel, child: Text(fuel))).toList(),
        onChanged: (value) {
          if (value != null) provider.setSelectedFuelType(value); // [STATE MANAGEMENT] helper method
        },
      ),
    );
  }

  Widget _buildBrandFilters() {
    final brands = ['Indian Oil', 'Bharath Petroleum', 'HP Petrol'];
    return SizedBox(
      height: 35,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return ChoiceChip(
            label: Text(brands[index]),
            selected: _selectedBrandIndex == index,
            onSelected: (selected) {
              if (selected) setState(() => _selectedBrandIndex = index);
            },
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(color: _selectedBrandIndex == index ? Colors.white : AppColors.text),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            side: BorderSide.none,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
      ),
    );
  }

  Widget _bunkSelector(FuelBunk? selectedBunk, List<FuelBunk> availableBunks, ValueChanged<FuelBunk?> onChanged) {
    if (selectedBunk == null) return const SizedBox();
    return Column(
      children: [
        Image.asset(selectedBunk.logoPath, height: 40),
        const SizedBox(height: 8),
        DropdownButton<FuelBunk>(
          value: selectedBunk,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.white),
          dropdownColor: const Color(0xFFD32F2F),
          borderRadius: BorderRadius.circular(12),
          items: availableBunks.map((bunk) => DropdownMenuItem(
            value: bunk,
            child: Text(bunk.name, style: const TextStyle(color: Colors.white)),
          )).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildSectionTitle(BuildContext context, String title, {bool showMore = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          if (showMore) const Icon(Icons.more_horiz, color: AppColors.subtext)
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _customServiceIcon("Puncture", 'lib/assets/images/tyre.png', () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
              ServicePlaceholderPage(title: "Puncture Shops", providers: mockPunctureShops)))),
          _customServiceIcon("Towing", 'lib/assets/images/pickup.png', () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
              ServicePlaceholderPage(title: "Towing Services", providers: mockTowingServices)))),
          _customServiceIcon("Fuel", 'lib/assets/images/fuel.png', () {}),
          _customServiceIcon("Oil Refill", 'lib/assets/images/oil_icon.png', () {}),
        ],
      ),
    );
  }

  Widget _customServiceIcon(String title, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyBunks(BuildContext context, AppProvider provider) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.bunks.length,
        itemBuilder: (context, index) {
          final station = provider.bunks[index];
          return FuelStationCard(
            // [FIX] Map imageGallery to single imagePath
            imagePath: station.imageGallery.isNotEmpty ? station.imageGallery.first : 'lib/assets/images/banner1.jpg',
            // [CLEAN CODE FIX] Passing navigation logic as a callback
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FuelStationDetailPage(
                    name: station.name,
                    image: station.imageGallery.isNotEmpty ? station.imageGallery.first : 'lib/assets/images/banner1.jpg',
                    rating: station.rating,
                  ),
                ),
              );
            },
            name: station.name,
            rating: station.rating,
            // [FIX] Map address to location
            location: station.address,
          );
        },
      ),
    );
  }
}