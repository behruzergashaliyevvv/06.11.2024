import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY, productName TEXT, price REAL, amount INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> createNote(String id, String productName, double price, int amount) async {
    final db = await SQLHelper.db();

    final data = {'id': id, 'productName': productName, 'price': price, 'amount': amount};
    await db.insert('notes', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await SQLHelper.db();
    return db.query('notes');
  }

  static Future<void> deleteNote(String id) async {
    final db = await SQLHelper.db();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
