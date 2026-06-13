import 'package:path/path.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:sqflite/sqflite.dart';

class RepeatedDatabaseEntry {
  late final Database connectionToDatabase;

  RepeatedDatabaseEntry() {
    connectToDatabase();
  }

  void connectToDatabase() async {
    connectionToDatabase =
        await openDatabase(join(await getDatabasesPath(), "scheduler.db"));
  }

  Future<void> saveToDB(TaskDataModel taskEntity) async {
    await connectionToDatabase.insert("active_task", taskEntity.toMap());
    return;
  }
}
