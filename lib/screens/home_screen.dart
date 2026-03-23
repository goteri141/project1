import 'package:flutter/material.dart';
import 'chapter_select_screen.dart';
import 'leaderboard_screen.dart';
import '../utils/routes.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mystery Companion'),
        actions: [
          Row(
            children: [
              // Switch for toggling theme
              const Icon(Icons.light_mode),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onThemeChanged,
              ),
              const Icon(Icons.dark_mode),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png',
              width: 300, 
              height: 300
            ),
            
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  fadeRoute(ChapterSelectScreen())
                );
              },
              child: const Text("Start Game"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  fadeRoute(LeaderboardScreen())
                );
              },
              child: const Text("Leaderboard"),
            ),
          ],
        ),
      ),
    );
  }
}