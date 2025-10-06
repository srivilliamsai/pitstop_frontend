import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for Google icon font

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Cover Image
          Image.asset(
            'lib/assets/images/login_bg.png', // <-- TODO: Add your background image here
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),

          // 2. Skip Button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),

          // 3. Login Form Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "India’s #1 Roadside Assistance App",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Log in or sign up",
                      style: TextStyle(fontSize: 14, color: AppColors.subtext),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "+91",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: const Text("Continue"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDivider(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google Icon using a Text widget
                        _buildSocialButton(
                          icon: Text(
                            'G',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          onTap: () {
                            // TODO: Implement Google Sign-In
                          },
                        ),
                        const SizedBox(width: 20),
                        // Apple Icon remains an image
                        _buildSocialButton(
                          icon: Image.asset(
                            'lib/assets/images/apple_icon.png', // <-- Keep Apple icon as an image
                            width: 24,
                            height: 24,
                          ),
                          onTap: () {
                            // TODO: Implement Apple Sign-In
                          },
                        ),
                        const SizedBox(width: 20),
                        // Mail Icon using a built-in Icon
                        _buildSocialButton(
                          icon: const Icon(
                            Icons.mail_outline,
                            size: 24,
                            color: AppColors.text,
                          ),
                          onTap: () {
                            // TODO: Implement Email Sign-In
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "By continuing, you agree to our\nTerms of Service • Privacy Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.subtext),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the "or" divider line.
  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("or", style: TextStyle(color: AppColors.subtext)),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  /// Builds a circular social login button with a generic icon widget.
  Widget _buildSocialButton({required Widget icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Center(child: icon),
      ),
    );
  }
}