import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';
// import 'order_tracking_page.dart'; // Make sure this page is also reskinned

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _orderCard(context, "Fuel Delivery", "Delivered", "2 km away", "10:45 AM"),
          _orderCard(context, "Tyre Replacement", "Ongoing", "5 km away", "ETA 15 min"),
          _orderCard(context, "Emergency Pickup", "Completed", "12 km away", "Yesterday"),
        ],
      ),
    );
  }

  Widget _orderCard(BuildContext context, String service, String status, String distance, String time) {
    Color statusColor;
    switch (status) {
      case "Ongoing":
        statusColor = Colors.orange.shade700;
        break;
      case "Completed":
      case "Delivered":
        statusColor = Colors.green.shade700;
        break;
      default:
        statusColor = AppColors.subtext;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                Text(distance, style: const TextStyle(color: AppColors.subtext)),
              ],
            ),
            Text(time, style: const TextStyle(color: AppColors.subtext)),
          ],
        ),
      ),
    );
  }
}