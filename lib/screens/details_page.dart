import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pitstop_frontend/models/place.dart'; // <-- FIX: Changed import
import 'package:pitstop_frontend/theme/theme.dart';

class DetailsPage extends StatefulWidget {
  final Place place; // <-- FIX: Changed from SearchableItem to Place

  const DetailsPage({super.key, required this.place}); // <-- FIX: Changed parameter

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildAddressAndActions(),
                  _buildTabs(),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: _buildTabBarView(),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("View your cart (3)"),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      title: Text("Search ${widget.place.name}", style: const TextStyle(fontSize: 16)), // FIX: item -> place
      actions: [_buildAppBarAction()],
    );
  }

  Widget _buildAppBarAction() {
    if (widget.place is FuelBunk) {
      return TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.local_gas_station, color: AppColors.primary, size: 16),
        label: const Text("Petrol"),
      );
    }
    return const SizedBox.shrink();
  }
  
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(widget.place.icon, size: 40, color: AppColors.primary), // FIX: item -> place
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.place.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)), // FIX: item -> place
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(widget.place.reviewCount, style: const TextStyle(color: AppColors.subtext)), // FIX: item -> place
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: const Text("Best Safety", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildAddressAndActions() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined, color: AppColors.subtext, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(widget.place.address, style: const TextStyle(fontSize: 14))), // FIX: item -> place
            const SizedBox(width: 16),
            const Icon(Icons.phone_outlined, color: AppColors.primary, size: 20),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.subtext,
      tabs: const [ Tab(text: "About"), Tab(text: "Photos"), Tab(text: "Reviews") ],
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildAboutTab(),
        const Center(child: Text("Photos coming soon")),
        const Center(child: Text("Reviews coming soon")),
      ],
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Container(
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: widget.place.coordinates, zoom: 15),
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                Marker(markerId: MarkerId(widget.place.name), position: widget.place.coordinates)
              },
            ),
          ),
          if (widget.place.recommendedProducts.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text("Our Experts Recommend", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            _buildRecommendedProducts(),
          ]
        ],
      ),
    );
  }

  Widget _buildRecommendedProducts() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.place.recommendedProducts.length,
        itemBuilder: (context, index) {
          final product = widget.place.recommendedProducts[index];
          return Card(
            child: SizedBox(
              width: 150,
              child: Column(
                children: [
                  Image.asset(product.imagePath, height: 100, fit: BoxFit.contain),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle, color: AppColors.primary)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}