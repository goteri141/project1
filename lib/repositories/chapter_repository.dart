import '../database_helper.dart';
import '../models/chapter.dart';

class ChapterRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Chapter>> getAllChapters() async {
    final rows = await dbHelper.getAllChapters();
      return rows.map((row) => Chapter(
        id: row['id'] as int,
        title: row['title'] as String,
        description: row['description'] as String,
      )).toList();
    }

  Future<Chapter?> getChapterById(int id) async {
    final row = await dbHelper.getChapter(id);
    if (row == null) return null;

    return Chapter(
      id: row['id'] as int,
      title: row['title'] as String,
      description: row['description'] as String,
    );
  }
}
