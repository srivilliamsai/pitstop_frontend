import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pitstop_frontend/screens/login_page.dart';
import 'package:pitstop_frontend/screens/main_page.dart';
import 'package:pitstop_frontend/theme/theme.dart';
import 'package:pitstop_frontend/providers/app_provider.dart';

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