import '../database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/chapter.dart';

class ChapterRepository {
  ChapterRepository();

  Future<List<Chapter>> getAllChapters() async {
  // Dummy chapter so chapter select can show something
  return Future.value([
    Chapter(id: 1, title: 'Chapter 1', description: 'Intro story...'),
  ]);
}

  // Implement later, maybe
  Future<Chapter?> getChapterById(int id) async {
    return Future.value(null);
  }
}