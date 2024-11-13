import 'package:scheduler/data/focus_session_data_model.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:path/path.dart';
import 'package:scheduler/data/old_task_data_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Future<void> saveActiveTask(TaskDataModel dataEntity) async {
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDataBase.insert('active_task', dataEntity.toMap());
    await connectToDataBase.close();
  }

  static Future<List<TaskDataModel>> fetchFromActiveDB() async {
    List<TaskDataModel> taskList = [];
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    List<Map> data = await connectToDataBase.query('active_task');
    for (final {
          'ID': iD as int,
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
            iD: iD,
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

  static Future<void> deleteFromActiveDB({required int iD}) async {
    final connectToDatabase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDatabase.delete(
      'active_task',
      where: 'ID = ?',
      whereArgs: [iD],
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

  static Future<void> saveFocusSessions(
      FocusSessionDataModel dataEntity) async {
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDataBase.insert('focus_sessions', dataEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await connectToDataBase.close();
  }

  static Future<List<FocusSessionDataModel>> fetchFromFocusSessionDB() async {
    List<FocusSessionDataModel> sessions = [];
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    List<Map> data = await connectToDataBase.query('focus_sessions');
    for (final {
          'minutes': minutes as int,
          'dateTime': dateTime as String,
          'taskType': taskType as String,
        } in data) {
      sessions.insert(
        0,
        FocusSessionDataModel(
          minutes: minutes,
          dateTime: DateTime.parse(dateTime),
          taskType: taskType,
        ),
      );
    }
    await connectToDataBase.close();
    return sessions;
  }
}
