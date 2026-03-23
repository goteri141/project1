import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MysteryCompanionApp());
}

class MysteryCompanionApp extends StatefulWidget {
  const MysteryCompanionApp({super.key});

  @override
  State<MysteryCompanionApp> createState() => _MysteryCompanionAppState();
}

class _MysteryCompanionAppState extends State<MysteryCompanionApp> {
  ThemeMode _themeMode = ThemeMode.light;

  // Function for toggling theme
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Companion',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomeScreen(
        onThemeChanged: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}