import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../repositories/puzzle_repository.dart';
import 'puzzle_screen.dart';
import '../utils/routes.dart';


class ChapterScreen extends StatefulWidget {
  final Chapter chapter;

  const ChapterScreen({super.key, required this.chapter});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {

  final TextEditingController teamController = TextEditingController();

  @override
  void dispose() {
    teamController.dispose();
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

            Text(widget.chapter.description),

            const SizedBox(height: 20),

            TextField(
              controller: teamController,
              decoration: const InputDecoration(
                labelText: "Team Name",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  fadeRoute(PuzzleScreen(
                    chapter: widget.chapter,
                    teamName: teamController.text,)
                  )
                );
              },
              child: const Text("Start Chapter"),
            ),
          ],
        ),
      ),
    );
  }
}