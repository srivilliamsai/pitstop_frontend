import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 60, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Guest User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.history, color: AppColors.primary),
                  title: Text('Order history'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.settings, color: AppColors.primary),
                  title: Text('Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}