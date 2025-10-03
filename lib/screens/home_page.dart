import 'package:flutter/material.dart';
import 'service_details_page.dart';
import 'orders_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Center(child: Text("Explore Page Coming Soon")),
    const OrdersPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/// ✅ Home Page Content (previous HomePage UI moved here)
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Welcome to PitStop",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text("Search fuel stations, hotels...",
                          style: TextStyle(color: Colors.grey.shade600))),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🚗 Services Section
            const Text("Our Services",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _serviceCard("Fuel", "lib/assets/images/fuel.png"),
                  _serviceCard("Emergency", "lib/assets/images/pickup.png"),
                  _serviceCard("Supermarket", "lib/assets/images/supermarket.png"),
                  _serviceCard("Hotels", "lib/assets/images/hotel.png"),
                  _serviceCard("Tyre", "lib/assets/images/tyre.png"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🏆 Recommended Section
            const Text("Recommended Stations",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("lib/assets/images/banner1.jpg",
                  fit: BoxFit.cover, width: double.infinity, height: 150),
            ),

            const SizedBox(height: 20),

            // 🛢 Nearby Fuel Stations Section
            const Text("Nearby Fuel Stations",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 12),

            Column(
              children: [
                _stationCard(
                  context,
                  "Indian Oil Pump",
                  "2.1 km away",
                  4.5,
                  "lib/assets/images/fuel_icon.png",
                ),
                _stationCard(
                  context,
                  "HP Petrol Station",
                  "3.8 km away",
                  4.2,
                  "lib/assets/images/fuel_icon.png",
                ),
                _stationCard(
                  context,
                  "Bharat Petroleum",
                  "5.0 km away",
                  4.8,
                  "lib/assets/images/fuel_icon.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔧 Service Card
  static Widget _serviceCard(String title, String iconPath) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 40, width: 40),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ⛽ Fuel Station Card (navigates to details page)
  static Widget _stationCard(BuildContext context, String name, String distance,
      double rating, String iconPath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ServiceDetailsPage(
                    stationName: name,
                    distance: distance,
                    rating: rating,
                  )),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red.shade50,
            child: Image.asset(iconPath, height: 28, width: 28),
          ),
          title: Text(name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text(distance),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              Text(rating.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}