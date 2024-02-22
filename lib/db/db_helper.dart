import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String _dbPath = "movie_db.db";
  static Database? _db;

  static Future<void> initDb() async {
    var dir = await getDatabasesPath();
    _db = await openDatabase("$dir/$_dbPath",
        onCreate: (Database db, int version) async {
          await db.execute("""
      CREATE TABLE Movie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT
      );
      """);
        }, version: 1);
  }

  static Database getDb() {
    if (_db == null) {
      throw Error();
    }

    return _db!;
  }
}