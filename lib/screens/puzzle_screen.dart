import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../models/puzzle.dart';
import '../repositories/puzzle_repository.dart';
import '../repositories/session_repository.dart';
import 'leaderboard_screen.dart';
import '../utils/routes.dart';


class PuzzleScreen extends StatefulWidget {
  final Chapter chapter;
  final String teamName;

  const PuzzleScreen({
    super.key,
    required this.chapter,
    required this.teamName,
  });

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {

  final PuzzleRepository puzzleRepository = PuzzleRepository();
  final SessionRepository sessionRepository = SessionRepository();

  List<Puzzle> puzzles = [];

  int currentIndex = 0;
  int hintsUsed = 0;

  late DateTime startTime;

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    loadPuzzles();
  }

  Future<void> loadPuzzles() async {
    // load puzzles later
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text("Puzzle ${currentIndex + 1} / ${puzzles.length}"),

            const SizedBox(height: 20),

            if (puzzles.isNotEmpty)
              Text(puzzles[currentIndex].question),

            const SizedBox(height: 20),

            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: "Your Answer",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black),
              onPressed: () {
                // checkAnswer later
                Navigator.push(
                  context,
                  fadeRoute(LeaderboardScreen())
                );
              },
              child: const Text("Submit"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black),
              onPressed: () {
                // showHint later
                
              },
              child: const Text("Hint"),
            ),
          ],
        ),
      ),
    );
  }
}