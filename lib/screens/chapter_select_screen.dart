import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../repositories/chapter_repository.dart';
import 'chapter_screen.dart';
import '../utils/routes.dart';


class ChapterSelectScreen extends StatefulWidget {
  const ChapterSelectScreen({super.key});

  @override
  State<ChapterSelectScreen> createState() => _ChapterSelectScreenState();
}

class _ChapterSelectScreenState extends State<ChapterSelectScreen> {
  final chapterRepo = ChapterRepository();
  List<Chapter> chapters = [];

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  // Call repo to get chapters
  Future<void> _loadChapters() async {
    final fetchedChapters = await chapterRepo.getAllChapters();
    setState(() {
      chapters = fetchedChapters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Chapter')),
      body: ListView.builder(
        // List that displays all chapters and preview of their story
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(chapter.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(chapter.description.split('\n')[0] + '..'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () { Navigator.push(
                            context,
                            fadeRoute(ChapterScreen(chapter: chapter))); },
                ),
              ),
            );
        },
      ),
    );
  }
}