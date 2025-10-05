import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';

class ServiceIcon extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const ServiceIcon({super.key, required this.title, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: AppColors.shadow.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: Image.asset(iconPath, height: 32, width: 32),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}