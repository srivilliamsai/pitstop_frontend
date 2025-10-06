import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/widgets/fuel_station_card.dart';
import 'package:pitstop_frontend/screens/service_pages.dart';
import 'package:pitstop_frontend/screens/search_page.dart';

class FuelBunk {
  final String name;
  final String logoPath;
  final String imagePath;
  final double rating;
  final String location;

  FuelBunk({
    required this.name,
    required this.logoPath,
    required this.imagePath,
    required this.rating,
    required this.location,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelBunk && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, double> _fuelPrices = {
    'Petrol': 102.63, 'Diesel': 94.24, 'Gas': 55.10, 'EV Charge': 22.50,
  };
  final Map<String, String> _fuelUnits = {
    'Petrol': '/litre', 'Diesel': '/litre', 'Gas': '/kg', 'EV Charge': '/kWh',
  };
  String _selectedFuelType = 'Petrol';

  final List<FuelBunk> _bunks = [
    FuelBunk(name: 'Indian Oil', logoPath: 'lib/assets/images/indian_oil_logo.png', imagePath: 'lib/assets/images/banner1.jpg', rating: 4.2, location: 'Perambur'),
    FuelBunk(name: 'Shell Bunk', logoPath: 'lib/assets/images/shell_logo.png', imagePath: 'lib/assets/images/banner2.jpg', rating: 4.5, location: 'Madhavaram'),
    FuelBunk(name: 'HP Petrol', logoPath: 'lib/assets/images/hp_logo.png', imagePath: 'lib/assets/images/banner1.jpg', rating: 4.0, location: 'Anna Nagar'),
    FuelBunk(name: 'BP Bunk', logoPath: 'lib/assets/images/bp_logo.png', imagePath: 'lib/assets/images/banner2.jpg', rating: 4.1, location: 'T. Nagar'),
  ];

  late FuelBunk _selectedBunk1;
  late FuelBunk _selectedBunk2;
  int _selectedBrandIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedBunk1 = _bunks[0];
    _selectedBunk2 = _bunks[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildFuelFinder(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "Our Services", showMore: true),
            _buildServicesGrid(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "${_bunks.length} Bunk Around You", showMore: true),
            _buildNearbyBunks(context),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Methods ---
  Widget _buildFuelFinder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_buildFuelTypeDropdown(), _buildFuelPriceDisplay()],
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
          _buildComparisonCard(),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    List<FuelBunk> availableBunksFor1 = _bunks.where((b) => b != _selectedBunk2).toList();
    List<FuelBunk> availableBunksFor2 = _bunks.where((b) => b != _selectedBunk1).toList();

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
  
  // All other helper methods remain the same
  Widget _buildHeader(BuildContext context) { /* ... same as before ... */ 
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
  Widget _buildFuelPriceDisplay() { /* ... same as before ... */ 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Text(
        "₹${_fuelPrices[_selectedFuelType]?.toStringAsFixed(2)} ${_fuelUnits[_selectedFuelType] ?? ''}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.text),
      ),
    );
  }
  Widget _buildFuelTypeDropdown() { /* ... same as before ... */ 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: DropdownButton<String>(
        value: _selectedFuelType,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        borderRadius: BorderRadius.circular(12),
        items: _fuelPrices.keys.map((fuel) => DropdownMenuItem(value: fuel, child: Text(fuel))).toList(),
        onChanged: (value) {
          if (value != null) setState(() => _selectedFuelType = value);
        },
      ),
    );
  }
  Widget _buildBrandFilters() { /* ... same as before ... */ 
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
  Widget _bunkSelector(FuelBunk selectedBunk, List<FuelBunk> availableBunks, ValueChanged<FuelBunk?> onChanged) { /* ... same as before ... */ 
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
  Widget _buildSectionTitle(BuildContext context, String title, {bool showMore = false}) { /* ... same as before ... */ 
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
  Widget _buildServicesGrid(BuildContext context) { /* ... same as before ... */ 
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
  Widget _customServiceIcon(String title, String iconPath, VoidCallback onTap) { /* ... same as before ... */ 
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
  Widget _buildNearbyBunks(BuildContext context) { /* ... same as before ... */ 
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _bunks.length,
        itemBuilder: (context, index) {
          final station = _bunks[index];
          return FuelStationCard(
            imagePath: station.imagePath,
            name: station.name,
            rating: station.rating,
            location: station.location,
          );
        },
      ),
    );
  }
}