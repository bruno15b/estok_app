import 'package:estok_app/repository/local/history_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InitDB {
  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "history_db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute('CREATE TABLE ${HistoryRepository.tableName} ('
            '${HistoryRepository.idHistoryColumn} INTEGER PRIMARY KEY, '
            '${HistoryRepository.operationType} TEXT, '
            '${HistoryRepository.entitiesType} TEXT, '
            '${HistoryRepository.dateTimeOperation} TEXT '
            ')');

      },
    );
  }
}
