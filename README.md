🚗 PitStop Frontend — On-Demand Roadside Assistance App

🧭 Overview

PitStop is a next-generation on-demand roadside assistance and fuel delivery application built with Flutter.
It provides quick access to emergency vehicle services like fuel delivery, towing, battery jumpstart, EV charging, puncture repair, and more — all visualized on an interactive Apple-style map UI with real-time location tracking.

The app emphasizes simplicity, speed, and precision, following Apple Human Interface Guidelines and Hick’s Law to reduce decision complexity for users under stress situations (like car breakdowns).

⸻

✨ Core Features

Category	Description
🚗 Real-Time Location Tracking	Uses GPS and Google Maps API to detect user’s live location instantly.
🗺️ Apple-Style Explore Page	Smooth glass-blur bottom sheet, floating navigation FAB, and modern map interaction.
⚡ Quick Service Shortcuts	One-tap access to key services: Fuel, Towing, Battery, EV, Hospital, etc.
🧭 Navigation FAB	Floating navigation button always visible, re-centers map with smooth animation.
🔍 Search-Optimized Interface	Smart search bar dynamically expands and collapses with smooth Apple-like transitions.
🌙 Dynamic Theme (Dark / Light)	Seamless switch with adaptive map styling (coming with JSON map style).
💬 Service Discovery	Easy navigation to nearby assistance providers (planned API integration).
🪄 Hick’s Law Optimized Design	Minimal choices per screen, maximizing speed and accuracy of decisions.


⸻

🧩 Tech Stack

Layer	Technology
Framework	Flutter (Dart 3.x)
UI Toolkit	Material 3 + Cupertino Design Principles
Mapping	Google Maps Flutter SDK
Location	location plugin
State Management	Stateful Widgets (planned: Provider / Riverpod)
API Layer	REST (to PitStop backend microservices)
Animation / Transitions	Implicit + Explicit Flutter Animations
Styling	Custom Theme via AppColors (from theme/theme.dart)


⸻

🗂️ Folder Structure

pitstop_frontend/
├── lib/
│   ├── main.dart
│   ├── theme/
│   │   └── theme.dart
│   ├── screens/
│   │   ├── explore_page.dart   ← Apple Maps–style Explore UI
│   │   ├── home_page.dart
│   │   ├── orders_page.dart
│   │   └── profile_page.dart
│   └── widgets/
│       ├── service_card.dart
│       ├── bottom_nav_bar.dart
│       └── blur_container.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md


⸻

🧠 UX Design Principle — Hick’s Law

“The time it takes to make a decision increases with the number and complexity of choices.”

PitStop’s UI follows Hick’s Law by reducing cognitive load:
	•	Displays only the most relevant services at once.
	•	Uses clear iconography for instant recognition (Fuel ⛽, Towing 🚚, Battery 🔋).
	•	Employs progressive disclosure — deeper actions appear only when needed.
	•	Ensures users act faster during emergencies with fewer distractions.

⸻

🧱 Explore Page Architecture

Section	Description
🗺️ Google Map Layer	Shows current location and surrounding POIs with clean Apple-style padding.
📜 DraggableScrollableSheet	Glass-blur panel that holds the search bar and service options.
🔍 Search Bar	Expands upward when focused; blurs background smoothly.
🧭 Floating FAB	Re-centers to user’s current location with smooth transition.
⚙️ Dynamic Padding	Map padding adjusts automatically when sheet height changes.


⸻

🚀 Quick Start Guide

Prerequisites
	•	Flutter SDK ≥ 3.3
	•	Android Studio / Xcode (for emulator)
	•	Google Maps API Key
	•	Location permission enabled on your test device

Setup Instructions

# 1️⃣ Clone repository
git clone https://github.com/srivilliamsai/pitstop_frontend.git
cd pitstop_frontend

# 2️⃣ Install dependencies
flutter pub get

# 3️⃣ Configure Google Maps API keys
# Android → android/app/src/main/AndroidManifest.xml
# iOS → ios/Runner/AppDelegate.swift + Info.plist

# 4️⃣ Run the app
flutter run


⸻

🧩 Key Dependencies

dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.2.5
  location: ^5.0.3
  cupertino_icons: ^1.0.5


⸻

🧭 Screens Overview

Screen	Purpose
HomePage	Default dashboard with service highlights.
ExplorePage	Interactive map and quick-service sheet.
OrdersPage	Shows active & past service requests.
ProfilePage	User details, preferences, and help options.


⸻

🧰 Design & Theming

Asset	Description
logo-light.png	Default light theme logo
logo-dark.png	Dark theme logo
AppColors.primary	#FF3B30 (PitStop Crimson Red)
AppColors.text	Graphite gray / white adaptive
AppColors.subtext	Muted neutral text tone
Typography	Poppins / SF Pro Rounded for Apple-style minimalism


⸻

🔄 Future Enhancements
	•	🔗 Real backend integration with PitStop microservices
	•	🪄 AI-based Service ETA Prediction
	•	🗺️ Apple-style dark map JSON theme switching
	•	🔔 Notification Center for Orders
	•	💳 In-app BNPL payments
	•	🧰 Mechanic tracking with socket updates

⸻

👨‍💻 Developer

Sri Villiam Sai Ayyappan
B.Tech (Information Technology), SRM Valliammai Engineering College
💼 Backend & Frontend Developer | UI/UX Designer
📍 Chennai, India

🔗 LinkedIn
🔗 GitHub

⸻

🪪 License

This project is licensed under the MIT License.
You are free to use, modify, and distribute with attribution.
