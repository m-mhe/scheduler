import 'package:flutter/material.dart';
import 'package:scheduler/ui/widgets/task_tile.dart';

class PreviousTasks extends StatefulWidget {
  const PreviousTasks({super.key});

  @override
  State<PreviousTasks> createState() => _PreviousTasksState();
}

class _PreviousTasksState extends State<PreviousTasks> {
  final DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
            itemBuilder: (context, i) {
              return TaskTile(taskTitle: 'Task Title', subTitle: 'Subtitle', taskState: 'Completed');
            },
            separatorBuilder: (context, i) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: 20),
      ),
    );
  }
}
