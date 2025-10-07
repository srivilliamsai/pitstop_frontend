import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pitstop_frontend/models/place.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/widgets/charts/fuel_price_chart.dart';
import 'package:pitstop_frontend/widgets/review_card.dart';

class DetailsPage extends StatefulWidget {
  final Place place;

  const DetailsPage({super.key, required this.place});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(widget.place.name),
              pinned: true,
              floating: true,
              actions: [_buildAppBarAction()],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildActionButtons(),
                    const Divider(height: 32),
                    if (widget.place is FuelBunk)
                      _buildFuelPrices(widget.place as FuelBunk),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.subtext,
                  tabs: const [
                    Tab(text: "About"),
                    Tab(text: "Photos"),
                    Tab(text: "Reviews"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAboutTab(),
            _buildPhotosTab(),
            _buildReviewsTab(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("View your cart (3)"),
        ),
      ),
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
    // You can return a different action for other service types here
    return const SizedBox.shrink();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(widget.place.logoPath, width: 50, height: 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.place.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("${widget.place.rating} ★ (${widget.place.reviewCount})", style: const TextStyle(color: AppColors.subtext)),
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

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.place.actionButtons.map((action) {
        return InkWell(
          onTap: () { /* Handle Action Tap */ },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  action == PlaceAction.directions ? Icons.directions_outlined :
                  action == PlaceAction.call ? Icons.call_outlined :
                  action == PlaceAction.save ? Icons.bookmark_border :
                  Icons.local_gas_station_outlined,
                  color: AppColors.primary
                ),
                const SizedBox(height: 4),
                Text(
                  action == PlaceAction.directions ? "Directions" :
                  action == PlaceAction.call ? "Call" :
                  action == PlaceAction.save ? "Save" :
                  "Book Fuel",
                  style: const TextStyle(color: AppColors.primary, fontSize: 12),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildFuelPrices(FuelBunk bunk) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Fuel Prices", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: bunk.prices.entries.map((e) => Expanded(
              child: Column(
                children: [ Text(e.key), Text("₹${e.value}", style: const TextStyle(fontWeight: FontWeight.bold)) ],
              ),
            )).toList(),
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.place is FuelBunk) ...[
            const Text("Daily Price History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            FuelPriceChart(priceHistory: (widget.place as FuelBunk).priceHistory),
            const SizedBox(height: 24),
          ],
          const Text("Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Container(
            height: 200,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: widget.place.coordinates, zoom: 15),
              markers: {Marker(markerId: MarkerId(widget.place.name), position: widget.place.coordinates)},
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPhotosTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: widget.place.imageGallery.length,
      itemBuilder: (context, index) {
        final isVideo = widget.place.imageGallery[index].contains('video');
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(widget.place.imageGallery[index], fit: BoxFit.cover)),
            if (isVideo) const Center(child: Icon(Icons.play_circle_fill, color: Colors.white70, size: 40)),
          ],
        );
      },
    );
  }
  
  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.place.reviews.length,
      itemBuilder: (context, index) => ReviewCard(review: widget.place.reviews[index]),
    );
  }
}

// Helper class to make the TabBar stick when scrolling
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}