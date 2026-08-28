#  PitStop Frontend

> **Next-Generation On-Demand Roadside Assistance App** \> Fuel Delivery • Emergency Support • EV Charging • Smart Navigation

-----

##  Overview

**PitStop** is a modern **Flutter-based mobile application** designed to provide instant on-road assistance for drivers — whether you’re out of fuel, have a flat tire, or need emergency medical help.
The app delivers **real-time location services**, **quick service booking**, and a **Zomato-style UI** built with **Apple-inspired design principles** and **Hick’s Law–optimized interactions**.

This repository contains the **complete frontend source code** for the PitStop app.

-----

##  Features

  -  **Real-Time Map View**

      - Google Maps integration with dynamic location tracking
      - Apple-style smooth floating navigation button
      - Intelligent bottom-sheet layout (Hick’s Law inspired)

  - ️ **Modular Service System**

      - Fuel delivery, towing, battery replacement, puncture repair
      - EV charging stations, hospitals, pharmacies & oil services

  -  **Beautiful Apple-Style UI**

      - Clean glassmorphism effects and curved bottom sheets
      - Light & Dark mode auto-detection
      - Soft shadows, motion-based transitions, and icon animations

  -  **Smart Navigation**

      - Floating navigation button always visible
      - Re-center to current location anytime

  -  **Optimized for Speed & UX**

      - Lightweight animations
      - Efficient state updates with minimal rebuilds
      - Follows Flutter’s performance best practices

-----

## ️ Folder Structure

```
pitstop_frontend/
│
├── android/                  # Android native build files
├── ios/                      # iOS native build files
├── assets/                   # App assets (images, icons, logos)
│   ├── icons/
│   └── screens/
│       └── ailment-preview.png
│
├── lib/
│   ├── main.dart             # Entry point
│   ├── theme/
│   │   └── theme.dart        # App-wide color & style definitions
│   ├── screens/
│   │   ├── explore_page.dart # Google Maps + Quick Services UI
│   │   ├── home_page.dart
│   │   ├── orders_page.dart
│   │   └── profile_page.dart
│   ├── widgets/              # Reusable components
│   └── utils/                # Helpers and constants
│
├── pubspec.yaml              # Dependencies and assets registration
├── README.md
└── LICENSE
```

-----

##  Tech Stack

| Layer | Technology | Description |
|:------|:------------|:-------------|
| **Framework** | Flutter 3.x | Cross-platform mobile development |
| **Language** | Dart | High-performance and type-safe |
| **Maps** | Google Maps Flutter SDK | Real-time map visualization |
| **Location** | Flutter Location Plugin | Device geolocation tracking |
| **UI/UX** | Apple-style glassmorphism + Material 3 | Clean, modern design |
| **State Mgmt** | Stateful Widgets | Simple and reactive architecture |

-----

##  Design Philosophy

The **PitStop UI** follows:

  - **Apple-grade minimalism** for visual calmness
  - **Hick’s Law** to reduce cognitive load by grouping related actions
  - **Zomato-style contrast** for visual clarity and service discoverability
  - **Tesla-style animation fluidity** for premium feel

-----

##  App Preview

| Explore Page | Dark Mode | Quick Services |
|:-------------:|:----------:|:---------------:|
|  |  |  |

-----

##  Screen Showcase

A glimpse into the core app flow, from authentication to managing your profile.

| Login Screen | Explore (Home) | My Orders | User Profile |
|:---:|:---:|:---:|:---:|
|  |  |  |  |

-----

##  Getting Started

### 1️⃣ Prerequisites

  - Flutter SDK 3.x+
  - Android Studio / Xcode
  - Google Maps API Key

### 2️⃣ Clone Repository

```bash
git clone https://github.com/srivilliamsai/pitstop_frontend.git
cd pitstop_frontend
```

### 3️⃣ Configure Google Maps

Create a `.env` or local configuration file to insert your Google Maps API keys for both platforms:

  - `android/app/src/main/AndroidManifest.xml`
  - `ios/Runner/AppDelegate.swift`

### 4️⃣ Install Dependencies

```bash
flutter pub get
```

### 5️⃣ Run App

```bash
flutter run
```

-----

 **Main Screen — `ExplorePage`**

  * Displays Google Map + Quick Service Panel
  * Interactive draggable bottom sheet
  * Always-visible floating navigation FAB
  * Auto camera re-center on tap
  * Clean dark/light adaptive UI

-----

 **Dependencies**

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  location: ^6.0.0
  cupertino_icons: ^1.0.8
```

-----

 **Future Enhancements**

  *  Real-time mechanic tracking
  *  Integrated payment gateway
  * ‍ Mechanic-side dashboard (Flutter Web)
  *  Analytics & notifications panel
  *  Firebase Auth for secure sign-in

-----

 **License**

This project is licensed under the MIT License — see the `LICENSE` file for details.

-----

‍ **Author**

**Sri Villiam Sai**  Software Developer | Flutter • Spring Boot • OCI Cloud
 Chennai, India
 [LinkedIn](https://www.linkedin.com/in/srivilliamsai/)
 [GitHub](https://github.com/srivilliamsai)

-----

 **Acknowledgements**

  * Google Maps Flutter Team
  * Material Design 3 Community
  * Apple Human Interface Guidelines
  * Flutter Dev Community

> “Empowering safe journeys, one tap at a time.” — PitStop Team