// Import required packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// DatabaseHelper class - Singleton pattern
class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  
  // Private constructor
  DatabaseHelper._init();
  
  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('myapp.db');
    return _database!;
  }
  
  // Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  
  // Create database tables
  Future _createDB(Database db, int version) async {
   
    // Users
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        created_at INTEGER
      )
    ''');

    // Story Chapters
    await db.execute('''
      CREATE TABLE chapters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        is_unlocked TEXT
      )
    ''');

    // Puzzles
    await db.execute('''
      CREATE TABLE puzzles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapter_id INTEGER,
        title TEXT NOT NULL,
        description TEXT,
        solution TEXT,
        time_limit INTEGER,
        FOREIGN KEY (chapter_id) REFERENCES chapters(id)
      )
    ''');

    // Session (Tracking Progress)
    await db.execute('''
      CREATE TABLE session (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER,
        puzzle_id INTEGER,
        status TEXT,
        title TEXT NOT NULL,
        description TEXT,
        start_time INTEGER,
        time_limit INTEGER,
        FOREIGN KEY (puzzle_id) REFERENCES puzzles(id)
      )
    ''');

    // Leaderboard (Display User's score)
    await db.execute('''
      CREATE TABLE leaderboard (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER,
        user_id INTEGER,
        rank INTEGER,
        time INTEGER,
        score INTEGER,

        FOREIGN KEY (session_id) REFERENCES session(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');

  }
  
  // CREATE - Insert new users
   Future<int> createUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  // CREATE - Insert new chapters
  Future<int> createChapter(Map<String, dynamic> chapter) async {
    final db = await database;
    return await db.insert('chapters', chapter);
  }

  // CREATE - Insert new puzzles
  Future<int> createPuzzle(Map<String, dynamic> puzzle) async {
    final db = await database;
    return await db.insert('puzzles', puzzle);
  }

  // CREATE - Create new sessions
  Future<int> createSession(Map<String, dynamic> session) async {
    final db = await database;
    return await db.insert('session', session);
  }

  // CREATE - Insert new user's score
  Future<int> createScore(Map<String, dynamic> score) async {
    final db = await database;
    return await db.insert('leaderboard', score);
  }


  // READ - Get all items
  Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await database;
    return await db.query('items', orderBy: 'created_at DESC');
  }
  
  // READ - Get single item by ID
  Future<Map<String, dynamic>?> getItem(int id) async {
    final db = await database;
    final results = await db.query(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  // UPDATE - Update existing item
  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await database;
    return await db.update(
      'items',
      item,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // DELETE - Remove item
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // Close database connection
  Future close() async {
    final db = await database;
    db.close();
  }
}