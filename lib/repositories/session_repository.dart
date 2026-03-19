import '../database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/session.dart';

class SessionRepository {
  SessionRepository();

  // TODO: Add functionality for these functions
  Future<int> createSession(Session session) async {
    return Future.value(1);
  }

  Future<void> updateSession(Session session) async {
    return Future.value();
  }

  Future<List<Session>> getLeaderboard() async {
    return Future.value([]);
  }
}