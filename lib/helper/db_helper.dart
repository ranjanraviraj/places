import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static const TABLE_PLACE = 'places';

  static const ID = 'id';
  static const TITLE = 'title';
  static const IMAGE = 'image';
  static const LATTITUDE = 'loc_lat';
  static const LONGITUDE = 'loc_lang';
  static const ADDRESS = 'address';

  static Future<sql.Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $TABLE_PLACE($ID TEXT PRIMARY KEY, $TITLE TEXT, $IMAGE TEXT, $LATTITUDE REAL, $LONGITUDE REAL, $ADDRESS TEXT)');
    });
  }

  static Future<void> insert(String tableName, Map<String, Object> data) async {
    final db = await DBHelper.getDatabase();
    db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await DBHelper.getDatabase();
    return db.query(tableName);
  }
}
