import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                "PitStop",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "India’s #1 Roadside Assistance App",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.text),
              ),
              const SizedBox(height: 50),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  prefixText: "+91 ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  child: const Text("Continue"),
                ),
              ),
              const Spacer(),
              const Text(
                "By continuing, you agree to our\nTerms of Service • Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.subtext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}