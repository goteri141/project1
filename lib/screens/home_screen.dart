import 'package:flutter/material.dart';
import 'chapter_select_screen.dart';
import 'leaderboard_screen.dart';
import '../utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mystery Puzzle Companion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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