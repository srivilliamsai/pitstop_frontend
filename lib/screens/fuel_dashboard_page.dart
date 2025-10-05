import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pitstop_frontend/providers/app_provider.dart';
import 'package:pitstop_frontend/theme/theme.dart';

class FuelDashboardPage extends StatefulWidget {
  const FuelDashboardPage({Key? key}) : super(key: key);

  @override
  State<FuelDashboardPage> createState() => _FuelDashboardPageState();
}

class _FuelDashboardPageState extends State<FuelDashboardPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> allBunks = ["Indian Oil", "Shell", "HP", "BPCL", "Reliance"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Added EV
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Prices'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBrandToggles(appProvider),
          const SizedBox(height: 16),
          _buildFuelTabs(),
          const SizedBox(height: 24),
          // You would pass the selected bunks to a comparison chart widget
          Text("Comparing: ${appProvider.selectedBunks.join(', ')}"),
        ],
      ),
    );
  }

  Widget _buildBrandToggles(AppProvider appProvider) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: allBunks.map((bunk) {
        final isSelected = appProvider.selectedBunks.contains(bunk);
        return ChoiceChip(
          label: Text(bunk),
          selected: isSelected,
          onSelected: (_) => appProvider.toggleBunkSelection(bunk),
          selectedColor: AppColors.primary.withOpacity(0.1),
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primary : AppColors.text),
        );
      }).toList(),
    );
  }

  Widget _buildFuelTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.subtext,
      indicatorColor: AppColors.primary,
      isScrollable: true,
      tabs: const [
        Tab(text: "Petrol"),
        Tab(text: "Diesel"),
        Tab(text: "Gas"),
        Tab(text: "EV"),
      ],
    );
  }
}