import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/orders_page.dart';

void main() {
  runApp(const PitStopApp());
}

class PitStopApp extends StatelessWidget {
  const PitStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PitStop",
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: "/login",
      routes: {
        "/login": (_) => const LoginPage(),
        "/home": (_) => const HomePage(),
        "/orders": (_) => const OrdersPage(),
      },
    );
  }
}