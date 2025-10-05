import 'package:flutter/material.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/screens/medical_details_page.dart';
import 'package:pitstop_frontend/screens/service_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Your Profile"),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAuthCard(context),
          const SizedBox(height: 24),

          // 🔹 Assistance section
          _buildSectionHeader("ASSISTANCE"),
          _buildOptionList([
            _buildListTile(Icons.book_outlined, "Address Book", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServicePlaceholderPage(
                    title: "Address Book",
                    providers: const [], // Empty placeholder
                  ),
                ),
              );
            }),
            _buildListTile(Icons.help_outline, "Online Ordering Help", () {}),
          ]),
          const SizedBox(height: 24),

          // 🔹 Health & Emergency section
          _buildSectionHeader("HEALTH & EMERGENCY"),
          _buildOptionList([
            _buildListTile(
              Icons.medical_services_outlined,
              "Emergency & Medical Details",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MedicalDetailsPage(),
                  ),
                );
              },
            ),
            _buildListTile(
              Icons.security_outlined,
              "Report a Safety Emergency",
              () {},
            ),
          ]),
          const SizedBox(height: 24),

          // 🔹 More section
          _buildSectionHeader("MORE"),
          _buildOptionList([
            _buildListTile(Icons.info_outline, "About", () {}),
            _buildListTile(Icons.feedback_outlined, "Send Feedback", () {}),
            _buildListTile(Icons.settings_outlined, "Settings", () {}),
          ]),
        ],
      ),
    );
  }

  /// 🔸 Top "Log in or sign up" card
  Widget _buildAuthCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Log in or sign up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "to view your complete profile",
            style: TextStyle(color: AppColors.subtext, fontSize: 14),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                // TODO: Navigate to Login/Signup page
              },
              child: const Text(
                "Continue",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Section header (e.g., ASSISTANCE)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.subtext,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  /// 🔸 Rounded list container
  Widget _buildOptionList(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(children: children),
    );
  }

  /// 🔸 Reusable tappable list tile
  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.text),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.subtext,
      ),
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
    );
  }
}