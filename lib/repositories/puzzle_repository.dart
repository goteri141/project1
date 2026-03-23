import '../models/puzzle.dart';
import '/database_helper.dart';

class PuzzleRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Puzzle>> getPuzzlesByChapter(int chapterId) async {
    final db = await dbHelper.database;
    final rows = await db.query(
      'puzzles',
      where: 'chapter_id = ?',
      whereArgs: [chapterId],
      orderBy: 'id ASC',
    );

    return rows.map((row) => Puzzle(
      id: row['id'] as int,
      chapterId: row['chapter_id'] as int,
      question: row['question'] as String,
      hint: row['hint'] as String,
      answer: (row['solution'] as String).split(','), // multiple answers
    )).toList();
  }
}