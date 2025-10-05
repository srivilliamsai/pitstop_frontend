import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';

class EmergencySosButton extends StatelessWidget {
  const EmergencySosButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Add emergency call or alert functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.sos),
            SizedBox(width: 12),
            Text("EMERGENCY SOS", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}