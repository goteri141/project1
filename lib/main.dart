import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        // More appealing font
        fontFamily: GoogleFonts.crimsonText().fontFamily,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18), // Default text style
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Text style for titles
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Style for input field
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),

      // Same theme data as above, but for dark mode
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.crimsonText().fontFamily,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18,),
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ), 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Color(0xFF2C2C2C),
        ),
      ),

      themeMode: _themeMode,
      home: HomeScreen(
        onThemeChanged: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
  }