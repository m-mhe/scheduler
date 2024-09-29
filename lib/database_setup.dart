import 'package:scheduler/data/entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSetup {
  static Future<void> saveTask(Entity dataEntity) async {
    final connectToDataBase = await openDatabase(
      join(await getDatabasesPath(), 'scheduler.db'),
    );
    await connectToDataBase.insert('active_task', dataEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await connectToDataBase.close();
  }

  static Future<List<Entity>> fetchFromActiveDB() async {
    List<Entity> taskList = [];
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
        Entity(
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
}
