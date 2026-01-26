import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pitstop_frontend/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService(); // [ARCHITECTURE] Using the service
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The default resizeToAvoidBottomInset: true works perfectly
      // with a SingleChildScrollView.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Background Cover Image (No changes needed here)
          Image.asset(
            'lib/assets/images/login_bg.png',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),

          // 2. Skip Button (No changes needed here)
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
              // --- FIX #1: WRAP THE FORM IN A SCROLLABLE WIDGET ---
              // This makes the form scrollable when the keyboard appears,
              // so the UI no longer gets squashed or overflows.
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Important for scroll view
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
                      // [SECURITY FIX] Added form key for validation
                      Form(
                        key: _formKey,
                        child: TextFormField( // Changed to TextFormField for validator
                          controller: _phoneController,
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
                          // [SECURITY FIX] Input Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a phone number";
                            }
                            if (value.length != 10) {
                              return "Phone number must be 10 digits";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : () async { // [SECURITY FIX] Disable button while loading
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              // [SECURITY FIX] Await AuthService response
                              final success = await _authService.loginWithPhone(_phoneController.text);
                              
                              setState(() {
                                _isLoading = false;
                              });

                              if (success) {
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(context, "/home");
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Login Failed. Try again.")),
                                  );
                                }
                              }
                            }
                          },
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Continue"),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildDivider(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          _buildSocialButton(
                            icon: Image.asset(
                              'lib/assets/images/apple_icon.png',
                              width: 24,
                              height: 24,
                            ),
                            onTap: () {
                              // TODO: Implement Apple Sign-In
                            },
                          ),
                          const SizedBox(width: 20),
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
                      // --- FIX #2: REPLACE SPACER WITH SIZEDBOX ---
                      // Spacer() causes errors in a scroll view. A SizedBox
                      // creates the needed space before the footer text.
                      const SizedBox(height: 48),
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
          ),
        ],
      ),
    );
  }

  /// Builds the "or" divider line. (No changes needed)
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

  /// Builds a circular social login button. (No changes needed)
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