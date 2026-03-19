import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MysteryCompanionApp());
}

class MysteryCompanionApp extends StatelessWidget {
  const MysteryCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Companion',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(),
    );
  }
}