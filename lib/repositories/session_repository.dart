import '../database_helper.dart';
import '../models/session.dart';

class SessionRepository {
  final dbHelper = DatabaseHelper.instance;

  Future<int> createSession(Session session) async {
    final db = await dbHelper.database;
    return await db.insert('sessions', {
      'chapter_id': session.chapterId,
      'chapter_title': session.chapterTitle,
      'team_name': session.teamName,
      'start_time': session.startTime,
      'end_time': session.endTime,
      'hints_used': session.hintsUsed,
    });
  }

  Future<void> updateSession(Session session) async {
    final db = await dbHelper.database;
    await db.update(
      'sessions',
      {
        'end_time': session.endTime,
        'hints_used': session.hintsUsed,
      },
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  Future<List<Session>> getLeaderboard() async {
    final db = await dbHelper.database;
    final rows = await db.query(
      'sessions',
      where: 'end_time IS NOT NULL',
      orderBy: 'hints_used ASC, (end_time - start_time) ASC',
    );
    return rows.map((row) => Session(
      id: row['id'] as int,
      chapterId: row['chapter_id'] as int,
      chapterTitle: row['chapter_title'] as String, // add this
      teamName: row['team_name'] as String,
      startTime: row['start_time'] as int,
      endTime: row['end_time'] as int?,
      hintsUsed: row['hints_used'] as int,
    )).toList();
  }
}