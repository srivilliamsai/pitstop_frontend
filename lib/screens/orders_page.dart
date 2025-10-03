import 'package:flutter/material.dart';
import 'order_tracking_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.red,
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OrderTrackingPage(orderId: "ORD123")),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  Text(status, style: TextStyle(color: status == "Ongoing" ? Colors.orange : Colors.green)),
                  Text(distance, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              Text(time, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}