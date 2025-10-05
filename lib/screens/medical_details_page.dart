import 'package:flutter/material.dart';

class MedicalDetailsPage extends StatelessWidget {
  const MedicalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medical Details")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text("Emergency Contact", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: "Name"),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          Text("Health Information", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
           const TextField(
            decoration: InputDecoration(labelText: "Blood Group"),
          ),
           const SizedBox(height: 8),
           const TextField(
            decoration: InputDecoration(labelText: "Allergies"),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Save logic here
              Navigator.pop(context);
            },
            child: const Text("Save Details"),
          )
        ],
      ),
    );
  }
}