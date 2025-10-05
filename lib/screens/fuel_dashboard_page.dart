// lib/screens/fuel_dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:pitstop_frontend/providers/app_provider.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import '../widgets/fuel_station_card.dart'; // Import the reusable widget

class FuelDashboardPage extends StatefulWidget {
  const FuelDashboardPage({Key? key}) : super(key: key);

  @override
  State<FuelDashboardPage> createState() => _FuelDashboardPageState();
}

class _FuelDashboardPageState extends State<FuelDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data remains the same
  final Map<String, List<double>> petrolPrices = {
    "Indian Oil": [98.5, 99.0, 98.8, 99.1, 99.2, 98.9, 99.0],
    "Shell Bunk": [99.2, 99.3, 99.1, 99.5, 99.4, 99.3, 99.2],
  };
  final Map<String, List<double>> dieselPrices = {
    "Indian Oil": [90.2, 90.1, 90.4, 90.3, 90.6, 90.5, 90.2],
    "Shell Bunk": [91.0, 90.9, 91.2, 91.1, 91.3, 91.2, 91.0],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<double> getPrices(String brand) {
    switch (_tabController.index) {
      case 1:
        return dieselPrices[brand]!;
      default:
        return petrolPrices[brand]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Comparison'),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBrandToggles(appProvider),
          const SizedBox(height: 16),
          _buildFuelTabs(),
          const SizedBox(height: 24),
          _buildPriceChart(appProvider.selectedBrand),
          const SizedBox(height: 24),
          Text(
            "Bunks Around You",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          _buildNearbyStationsList(),
        ],
      ),
    );
  }

  Widget _buildBrandToggles(AppProvider appProvider) {
    return Row(
      children: [
        _brandChip("Indian Oil", appProvider),
        const SizedBox(width: 10),
        _brandChip("Shell Bunk", appProvider),
      ],
    );
  }

  Widget _brandChip(String brand, AppProvider appProvider) {
    final bool isSelected = appProvider.selectedBrand == brand;
    return ChoiceChip(
      label: Text(brand),
      selected: isSelected,
      onSelected: (_) => appProvider.selectBrand(brand),
      selectedColor: AppColors.primary.withOpacity(0.1),
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.primary : AppColors.text),
      side: isSelected
          ? const BorderSide(color: AppColors.primary)
          : const BorderSide(color: AppColors.border),
    );
  }

  Widget _buildFuelTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.subtext,
      indicatorColor: AppColors.primary,
      tabs: const [
        Tab(text: "Petrol"),
        Tab(text: "Diesel"),
        Tab(text: "Gas"),
      ],
    );
  }

  Widget _buildPriceChart(String brand) {
    final prices = getPrices(brand);
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: prices.reduce((a, b) => a > b ? a : b) + 1,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(days[value.toInt() % 7]),
                ),
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: prices
              .asMap()
              .entries
              .map((e) => BarChartGroupData(x: e.key, barRods: [
                    BarChartRodData(
                      toY: e.value,
                      color: AppColors.primary,
                      width: 14,
                      borderRadius: BorderRadius.circular(6),
                    )
                  ]))
              .toList(),
        ),
      ),
    );
  }

  // IMPROVED: This now uses the reusable FuelStationCard widget.
  Widget _buildNearbyStationsList() {
    final stations = [
       {
        "image": 'lib/assets/images/banner2.jpg',
        "name": "Shell Petrol Bunk",
        "rating": 4.5,
        "location": "Madhavaram Milk Colony",
      },
      {
        "image": 'lib/assets/images/banner1.jpg',
        "name": "Indian Oil Pump",
        "rating": 4.2,
        "location": "Perambur",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          // Using the reusable widget here for consistency
          child: FuelStationCard(
            imagePath: station['image'] as String,
            name: station['name'] as String,
            rating: station['rating'] as double,
            location: station['location'] as String,
          ),
        );
      },
    );
  }
}