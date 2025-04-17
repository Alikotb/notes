import 'package:sqflite/sqflite.dart';
import "package:path/path.dart" show join;

import '../model/note_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  static Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'note_db.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        // Create user table
        await db.execute('''
        CREATE TABLE notes (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        date TEXT NOT NULL,
        isImportant INTEGER NOT NULL
        )
      ''');
      },
    );
  }

  Future<int> insertNote(NotesModel note) async {
    final db = await database;
    return await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNote(NotesModel note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'title = ?',
      whereArgs: [note.title],
    );
  }

  Future<int> deleteNote(String title) async {
    final db = await database;
    return await db.delete('notes', where: 'title = ?', whereArgs: [title]);
  }

  Future<NotesModel?> getNoteByTitle(String title) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'title = ?',
      whereArgs: [title],
    );
    if (maps.isNotEmpty) {
      return NotesModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<NotesModel>> getAllNotes() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return NotesModel.fromMap(maps[i]);
    });
  }
}
