import 'package:flutter/material.dart';
import 'package:scheduler/data/entity_two.dart';
import 'package:scheduler/database_setup.dart';
import 'package:scheduler/ui/widgets/task_tile.dart';

class PreviousTasks extends StatefulWidget {
  const PreviousTasks({super.key});

  @override
  State<PreviousTasks> createState() => _PreviousTasksState();
}

class _PreviousTasksState extends State<PreviousTasks> {
  List<EntityTwo> _allTasks = [];

  Future<void> _fetch() async{
    _allTasks = await DatabaseSetup.fetchFromInactiveDB();
    setState(() {});
  }

  @override
  void initState() {
    _fetch();
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
                onTap: () {},
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
