import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/home_page.dart';

void main() => runApp(const PitStopApp());

class PitStopApp extends StatelessWidget {
  const PitStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PitStop',
      theme: AppTheme.lightTheme,
      home: HomePage(),
    );
  }
}
