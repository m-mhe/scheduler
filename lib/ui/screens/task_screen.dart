import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
            itemBuilder: (context, i) {
              return TaskTile(taskTitle: 'Task Title', subTitle: 'Task Subtitle', taskState: 'Due');
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: 20),
      ),
    );
  }
}
