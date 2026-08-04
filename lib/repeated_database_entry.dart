import 'package:path/path.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:sqflite/sqflite.dart';

class RepeatedDatabaseEntry {
  late final Database _connectionToDatabase;

  RepeatedDatabaseEntry() {
    connectToDatabase();
  }

  void connectToDatabase() async {
    _connectionToDatabase =
        await openDatabase(join(await getDatabasesPath(), "scheduler.db"));
    return;
  }

  Future<void> saveToDB(TaskDataModel taskEntity) async {
    await _connectionToDatabase.insert("active_task", taskEntity.toMap());
    return;
  }

  void disconnectFromDatabase() async{
    await _connectionToDatabase.close();
  }
}
