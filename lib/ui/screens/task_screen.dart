import 'package:flutter/material.dart';
import 'package:scheduler/data/entity.dart';
import 'package:scheduler/database_setup.dart';
import 'package:scheduler/ui/widgets/ask_task_complete_confirmation.dart';
import '../widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Entity> _allTasks = [];

  Future<void> fetch() async {
    _allTasks = await DatabaseSetup.fetchFromActiveDB();
    setState(() {});
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
            itemBuilder: (context, i) {
              return TaskTile(
                taskTitle: _allTasks[i].title,
                subTitle: _allTasks[i].subTitle,
                taskStatus: _allTasks[i].taskState,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AskTaskCompleteConfirmation();
                    },
                  );
                },
              );
            },
            separatorBuilder: (context, i) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: _allTasks.length),
      ),
    );
  }
}
