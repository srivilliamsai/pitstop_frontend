import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'fuel_station_detail_page.dart';

class FuelDashboardPage extends StatefulWidget {
  const FuelDashboardPage({Key? key}) : super(key: key);

  @override
  State<FuelDashboardPage> createState() => _FuelDashboardPageState();
}

class _FuelDashboardPageState extends State<FuelDashboardPage>
    with SingleTickerProviderStateMixin {
  String activeBrand = 'Indian Oil';
  late TabController _tabController;

  //  Strongly typed mock data
  final Map<String, List<double>> petrolPrices = {
    "Indian Oil": [98.5, 99.0, 98.8, 99.1, 99.2, 98.9, 99.0],
    "Shell Bunk": [99.2, 99.3, 99.1, 99.5, 99.4, 99.3, 99.2],
  };

  final Map<String, List<double>> dieselPrices = {
    "Indian Oil": [90.2, 90.1, 90.4, 90.3, 90.6, 90.5, 90.2],
    "Shell Bunk": [91.0, 90.9, 91.2, 91.1, 91.3, 91.2, 91.0],
  };

  final Map<String, List<double>> gasPrices = {
    "Indian Oil": [65.2, 65.3, 65.5, 65.4, 65.3, 65.6, 65.2],
    "Shell Bunk": [66.1, 66.0, 66.2, 66.3, 66.4, 66.1, 66.0],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<double> get currentPrices {
    switch (_tabController.index) {
      case 1:
        return dieselPrices[activeBrand]!;
      case 2:
        return gasPrices[activeBrand]!;
      default:
        return petrolPrices[activeBrand]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Fuel Prices', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBrandToggles(),
            const SizedBox(height: 16),
            _buildFuelTabs(),
            const SizedBox(height: 16),
            _buildPriceChart(),
            const SizedBox(height: 24),
            const Text(
              "32 Bunks Around You",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildNearbyStations(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandToggles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _brandButton("Indian Oil"),
        const SizedBox(width: 10),
        _brandButton("Shell Bunk"),
      ],
    );
  }

  Widget _brandButton(String brand) {
    final isActive = activeBrand == brand;
    return GestureDetector(
      onTap: () => setState(() => activeBrand = brand),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          brand,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.blueAccent : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildFuelTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.blueAccent,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.blueAccent,
      tabs: const [
        Tab(text: "Petrol"),
        Tab(text: "Diesel"),
        Tab(text: "Gas"),
      ],
      onTap: (_) => setState(() {}),
    );
  }

  Widget _buildPriceChart() {
    final prices = currentPrices;
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 8, spreadRadius: 2),
        ],
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
                  child: Text(
                    days[value.toInt() % 7],
                    style: const TextStyle(fontSize: 12),
                  ),
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
              .map(
                (e) => BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value,
                      color: Colors.blueAccent,
                      width: 14,
                      borderRadius: BorderRadius.circular(6),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildNearbyStations(BuildContext context) {
    final List<Map<String, dynamic>> stations = [
      {
        "name": "Shell Petrol Bunk",
        "rating": 4.5,
        "image":
            "https://images.unsplash.com/photo-1606813907383-87a9a95fe8ff"
      },
      {
        "name": "Indian Oil Station",
        "rating": 4.3,
        "image":
            "https://images.unsplash.com/photo-1525609004556-c46c7d6cf023"
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        final name = station["name"].toString();
        final image = station["image"].toString();
        final rating = (station["rating"] as num).toDouble();

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(rating.toString()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => FuelStationDetailPage(
                              name: name,
                              image: image,
                              rating: rating,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              final tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: Curves.easeInOut));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Pricing Comparison"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}