import 'package:flutter/material.dart';
import 'package:scheduler/app.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase(join(await getDatabasesPath(), 'scheduler.db'),
      onCreate: (Database db, int v) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS active_task(title TEXT, subtitle TEXT, taskState TEXT, fromTime INTEGER, toTime INTEGER, date INTEGER, month INTEGER, year INTEGER)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS inActive_task(title TEXT, subtitle TEXT, taskState TEXT)');
  }, version: 1);
  runApp(const MyApp());
}
