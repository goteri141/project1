import '../database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/chapter.dart';

class ChapterRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Chapter>> getAllMissions() async {
    final db = await dbHelper.database;
    final result = await db.query('missions');

    return result.map((e) => Chapter.fromMap(e)).toList();
  }
}