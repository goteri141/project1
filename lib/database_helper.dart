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
        created_at TEXT NOT NULL
      )
    ''');

    // Story Chapters
    await db.execute('''
      CREATE TABLE chapters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        is_unlocked TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Puzzles
    await db.execute('''
      CREATE TABLE puzzles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chapter_id INTEGER,
        title TEXT NOT NULL,
        question TEXT,
        hint TEXT,
        solution TEXT,
        time_limit INTEGER,
        created_at TEXT NOT NULL,
        FOREIGN KEY (chapter_id) REFERENCES chapters(id)
      )
    ''');

    // Sessions (Tracking Progress)
    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER,
        puzzle_id INTEGER,
        status TEXT,
        title TEXT NOT NULL,
        description TEXT,
        start_time INTEGER,
        time_limit INTEGER,
        created_at TEXT NOT NULL,

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
        created_at TEXT NOT NULL,

        FOREIGN KEY (session_id) REFERENCES session(id),
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');

    final chapters = [
  {
    'id': 01,
    'title': 'Chapter 1 - The Gate',
    'description': "Welcome to the Mystery Puzzle & Escape Room Companion.\nYou will step into the role of a detective.\nThe victim, Sarah Thompson, a 34-year-old woman, was found dead inside her mansion with no signs of forced entry.\nYou arrived at Ms. Thompson's mansion.\nBut something stands in your way.\nThe iron gate is locked.\nSolve the riddle to gain access to the mansion.",
  },
  {
    'id': 02,
    'title': 'Chapter 2 - Into the Rose Garden',
    'description': "The iron gate slowly opens.\nYou step inside and walked along the paved walkway.\n You stumbled upon the rose garden.\nThe path is narrow, surrounded by towering bushes of thorns and blooms.\nYou've noticed something strange.\nHalf of the roses in the garden are darker, their petails slightly wilted like someone intentionally did it.\nSolve the riddle to uncover the clue in the garden.",
  },
  {
    'id': 03,
    'title': 'Chapter 3 - A Bloody Entrance',
    'description': "You approach the front door of the mansion.\nAs you attempt to open the door, a dark, handprint stain marks the handle... blood.\nBut there are no signs of struggle nearby. No broken glass or forced entry.\nSomething about this doesn't add up. \nYou open the door.\nBefore you stepped inside, you noticed a clue.\nSolve the riddle to uncover what happened at the entrance.",
  },
  {
    'id': 04,
    'title': 'Chapter 4 - The Haunted Mansion',
    'description': "The door shuts behind you as you make your way inside.\nFurniture neatly arranged, as if nothing ever happened.\nPortraits line the walls, giviing off a creepy and eerie aura.\nHowever, you've noticed one frame is missing.\nSolve the riddle to uncover the missing portrait.",
  },
  {
    'id': 05,
    'title': 'Chapter 5 - The Bedroom',
    'description': "You walked upstairs and made your way to the bedroom at the beginning of the hall.\nThis is where Sarah Thompson was found.\nThe room is dark, you turned on your flashlight and found a diary opened on the nightstand.\nYou look through the pages, but one entry stands out.\nIt felt rushed like she knew something. Maybe even the person responsible for her death.\nSolve the riddle to uncover the truth in her message.   ",
  },
];
    for (var chapter in chapters) {
      await db.insert('chapters', chapter);
    }

    final puzzles = [
  {
    'id': 001,
    'chapter_id': 01,
    'question': 'sample',
    'answer': 'sample',
    'hint': 'sample',
  },
  {
    'id': 002,
    'chapter_id': 02,
    'question': 'You look at a section of roses: \nHealthy, wilted, healthy, wilted.\n\nWhat condition is the next rose in?',
    'answer': 'healthy',
    'hint': 'Look at the repeating pattern',
  },
  {
    'id': 003,
    'chapter_id': 03,
    'question': 'The door was unlocked.\n',
    'answer': 'sample',
    'hint': 'sample',
  },
  {
    'id': 004,
    'chapter_id': 04,
    'question': 'There is a note scratched on the wall where the portrait would be:\n"TIAROTR"\nUnscramble the word',
    'answer': 'traitor',
    'hint': 'Someone close to her may be involved.',
  },
  {
    'id': 005,
    'chapter_id': 05,
    'question': 'The entry seems to be a code. It reads:\n',
    'answer': 'sample',
    'hint': 'sample',
  },
];

  for (var puzzle in puzzles) {
      await db.insert('puzzles', puzzle);
  }
  

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
    return await db.insert('sessions', session);
  }

  // CREATE - Insert new user's score
  Future<int> createScore(Map<String, dynamic> score) async {
    final db = await database;
    return await db.insert('leaderboard', score);
  }


  // READ - Get all Users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users', orderBy: 'created_at DESC');
  }

  // READ - Get all Chapters
  Future<List<Map<String, dynamic>>> getAllChapters() async {
    final db = await database;
    return await db.query('chapters', orderBy: 'created_at DESC');
  }

  // READ - Get all Puzzles
  Future<List<Map<String, dynamic>>> getAllPuzzles() async {
    final db = await database;
    return await db.query('puzzles', orderBy: 'created_at DESC');
  }

  // READ - Get all Sessions
  Future<List<Map<String, dynamic>>> getAllSessions() async {
    final db = await database;
    return await db.query('sessions', orderBy: 'created_at DESC');
  }

 // READ - Get all Users' scores
 Future<List<Map<String, dynamic>>> getAllScores() async {
    final db = await database;
    return await db.query('leaderboard', orderBy: 'created_at DESC');
  }


  
  // READ - Get single user by ID
  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // READ - Get single chapter by ID
  Future<Map<String, dynamic>?> getChapter(int id) async {
    final db = await database;
    final results = await db.query(
      'chapters',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // READ - Get single puzzle by ID
  Future<Map<String, dynamic>?> getPuzzle(int id) async {
    final db = await database;
    final results = await db.query(
      'puzzles',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

   // READ - Get single puzzle by ID
  Future<Map<String, dynamic>?> getSession(int id) async {
    final db = await database;
    final results = await db.query(
      'sessions',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

   // READ - Get single uuser's score by ID
  Future<Map<String, dynamic>?> getScore(int id) async {
    final db = await database;
    final results = await db.query(
      'leaderboard',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  // UPDATE - Update existing user
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // UPDATE - Update existing chapter
  Future<int> updateChapter(int id, Map<String, dynamic> chapter) async {
    final db = await database;
    return await db.update(
      'chapters',
      chapter,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // UPDATE - Update existing puzzle
  Future<int> updatePuzzle(int id, Map<String, dynamic> puzzle) async {
    final db = await database;
    return await db.update(
      'puzzles',
      puzzle,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // UPDATE - Update existing session
  Future<int> updateSession(int id, Map<String, dynamic> session) async {
    final db = await database;
    return await db.update(
      'sessions',
      session,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // UPDATE - Update existing user's score
  Future<int> updateScore(int id, Map<String, dynamic> score) async {
    final db = await database;
    return await db.update(
      'leaderboard',
      score,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // DELETE - Remove user
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Remove chapter
  Future<int> deleteChapter(int id) async {
    final db = await database;
    return await db.delete(
      'chapters',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Remove puzzle
  Future<int> deletePuzzle(int id) async {
    final db = await database;
    return await db.delete(
      'puzzles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Remove session
  Future<int> deleteSession(int id) async {
    final db = await database;
    return await db.delete(
      'sessions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Remove score
  Future<int> deleteScore(int id) async {
    final db = await database;
    return await db.delete(
      'leaderboard',
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