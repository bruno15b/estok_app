import 'package:estok_app/entities/history.dart';
import 'package:sqflite/sqflite.dart';
import 'database/init_db.dart';

class HistoryRepository {
  static final String tableName = "history_db";
  static final String idHistoryColumn = "id";
  static final String operationType = "operationType";
  static final String objectType = "objectType";
  static final String objectName= "objectName";
  static final String dateTimeOperation = "dateTimeOperation";

  static final HistoryRepository instance = HistoryRepository._();

  HistoryRepository._();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await InitDB.initDatabase();
    }
    return _database;
  }

  Future<History> save(History history) async {
    Database db = await database;
    history.id = await db.insert(tableName, history.toJson());
    return history;
  }

  Future<List<History>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM $tableName");
    return result.map((map) => History.fromJson(map)).toList();
  }


}
