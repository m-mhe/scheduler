import 'package:scheduler/data/task_data_model.dart';
import 'package:path/path.dart';
import 'package:scheduler/data/old_task_data_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSetup {
  static Future<void> saveActiveTask(TaskDataModel dataEntity) async {
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDataBase.insert('active_task', dataEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await connectToDataBase.close();
  }

  static Future<List<TaskDataModel>> fetchFromActiveDB() async {
    List<TaskDataModel> taskList = [];
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    List<Map> data = await connectToDataBase.query('active_task');
    for (final {
          'title': title as String,
          'subtitle': subtitle as String,
          'taskState': taskState as String,
          'fromTime': fromTime as int,
          'toTime': toTime as int,
          'date': date as int,
          'month': month as int,
          'year': year as int
        } in data) {
      taskList.add(
        TaskDataModel(
            title: title,
            subTitle: subtitle,
            taskState: taskState,
            fromTime: fromTime,
            toTime: toTime,
            month: month,
            year: year,
            date: date),
      );
    }
    await connectToDataBase.close();
    return taskList;
  }

  static Future<void> deleteFromActiveDB(String title) async {
    final connectToDatabase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDatabase.delete(
      'active_task',
      where: 'title = ?',
      whereArgs: [title],
    );
    await connectToDatabase.close();
  }

  static Future<void> saveInactiveTask(OldTaskDataModel dataEntity) async {
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDataBase.insert('inActive_task', dataEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await connectToDataBase.close();
  }

  static Future<List<OldTaskDataModel>> fetchFromInactiveDB() async {
    List<OldTaskDataModel> taskList = [];
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    List<Map> data = await connectToDataBase.query('inActive_task');
    for (final {
          'title': title as String,
          'subtitle': subtitle as String,
          'taskState': taskState as String,
        } in data) {
      taskList.insert(
        0,
        OldTaskDataModel(
          title: title,
          subTitle: subtitle,
          taskState: taskState,
        ),
      );
    }
    await connectToDataBase.close();
    return taskList;
  }
}
