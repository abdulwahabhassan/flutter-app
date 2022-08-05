import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class SQLiteHelper {
  static Future<void> createTables(Database database) async {
    await database.execute('''CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        title TEXT, 
        body TEXT, 
        date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        )''');
  }

  static Future<Database> db() async {
    return openDatabase(join(await getDatabasesPath(), 'notes_database.db'),
        onCreate: (db, version) async {
      await createTables(db);
    }, version: 1);
  }

  static Future<void> insertNote(Note note) async {
    final db = await SQLiteHelper.db();
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await SQLiteHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          date: maps[i]['date']);
    });
  }

  static Future<void> updateNote(Note note) async {
    final db = await SQLiteHelper.db();
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  static Future<void> deleteNote(int id) async {
    final db = await SQLiteHelper.db();
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
