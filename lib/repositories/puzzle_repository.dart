import '../database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/puzzle.dart';

class PuzzleRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Puzzle>> getPuzzlesByChapter(int chapterId) async {
    final db = await dbHelper.database;
    final result = await db.query('chapters');

    return result.map((e) => Puzzle.fromMap(e)).toList();
  }
}