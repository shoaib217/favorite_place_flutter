import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,long REAL,address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.getDatabase(); 
    sqlDb.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

static Future<List<Map<String,dynamic>>> getData(String table) async{
  final db = await DBHelper.getDatabase();
  return db.query(table);
  
}

}
