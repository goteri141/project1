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

  final ChapterRepository chapterRepository = ChapterRepository();

  late Future<List<Chapter>> chaptersFuture;

  @override
  void initState() {
    super.initState();
    chaptersFuture = chapterRepository.getAllChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Chapter"),
      ),
      body: FutureBuilder<List<Chapter>>(
        future: chaptersFuture,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chapters = snapshot.data!;

          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];

              return ListTile(
                title: Text(chapter.title),
                subtitle: Text(chapter.description),
                onTap: () {
                  Navigator.push(
                    context,
                    fadeRoute(ChapterScreen(chapter: chapter))
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}