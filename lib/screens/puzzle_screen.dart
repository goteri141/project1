import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../models/puzzle.dart';
import '../repositories/puzzle_repository.dart';
import '../repositories/session_repository.dart';
import 'leaderboard_screen.dart';
import '../utils/routes.dart';
import '../models/session.dart';

class PuzzleScreen extends StatefulWidget {
  final Chapter chapter;
  final String teamName;

  const PuzzleScreen({
    super.key, 
    required this.chapter, 
    required this.teamName});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  final PuzzleRepository puzzleRepository = PuzzleRepository();
  final SessionRepository sessionRepository = SessionRepository();

  List<Puzzle> puzzles = [];
  int currentIndex = 0;
  int hintsUsed = 0;
  late int startTime;
  int? sessionId;

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now().millisecondsSinceEpoch;
    loadPuzzles();
  }

  Future<void> loadPuzzles() async {
    final fetched = await puzzleRepository.getPuzzlesByChapter(widget.chapter.id);
    // Create session when puzzles load
    final id = await sessionRepository.createSession(Session(
      chapterId: widget.chapter.id,
      chapterTitle: widget.chapter.title,
      teamName: widget.teamName,
      startTime: startTime,
      endTime: null,
      hintsUsed: 0,
    ));
    setState(() {
      puzzles = fetched;
      sessionId = id;
    });
  }

  void submitAnswer() async {
    // avoid case sensitivity by converting to lowercase
    final userAnswer = answerController.text.trim().toLowerCase();
    final correctAnswers = puzzles[currentIndex].answer.map((a) => a.toLowerCase()).toList();

    // Check if user's answer is in the correct answers list
    if (correctAnswers.contains(userAnswer)) {
      if (currentIndex + 1 < puzzles.length) {
        setState(() {
          currentIndex++;
          answerController.clear();
        });
      } else {
        // Save completed session if user's answer is correct
        final endTime = DateTime.now().millisecondsSinceEpoch;
        await sessionRepository.updateSession(Session(
          id: sessionId,
          chapterId: widget.chapter.id,
          chapterTitle: widget.chapter.title,
          teamName: widget.teamName,
          startTime: startTime,
          endTime: endTime,
          hintsUsed: hintsUsed,
        ));

        Navigator.pushReplacement(
          context,
          fadeRoute(LeaderboardScreen()),
        );
      }
    // If user's answer is incorrect, tell them to try again
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect answer, try again!")),
      );
    }
  }

  void showHint() {
    setState(() {
      hintsUsed++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(puzzles[currentIndex].hint)),
    );
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (puzzles.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.chapter.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final puzzle = puzzles[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.chapter.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Puzzle ${currentIndex + 1} / ${puzzles.length}"),
            const SizedBox(height: 20),
            Text(puzzle.question),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: "Your Answer"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black),
              onPressed: submitAnswer,
              child: const Text("Submit"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black),
              onPressed: showHint,
              child: const Text("Hint"),
            ),
          ],
        ),
      ),
    );
  }
}