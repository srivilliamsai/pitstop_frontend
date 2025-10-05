import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart'; // New main navigation page
import 'theme/theme.dart';
import 'providers/app_provider.dart';

void main() {
  runApp(const PitStopApp());
}

class PitStopApp extends StatelessWidget {
  const PitStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "PitStop",
        theme: AppTheme.lightTheme,
        initialRoute: "/login",
        routes: {
          "/login": (_) => const LoginPage(),
          "/home": (_) => const MainPage(),
        },
      ),
    );
  }
}