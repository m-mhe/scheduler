import 'package:flutter/material.dart';
import 'package:scheduler/data/entity.dart';
import 'package:scheduler/database_setup.dart';
import 'package:scheduler/ui/widgets/ask_task_complete_confirmation.dart';
import '../utils/theme_colors.dart';
import '../widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Entity> _allTasks = [];

  Future<void> _fetch() async {
    final DateTime currentTime = DateTime.now();
    List<Entity> dataList = await DatabaseSetup.fetchFromActiveDB();
    for (Entity data in dataList) {
      if (data.toTime < currentTime.hour ||
          data.date < currentTime.day ||
          data.month < currentTime.month ||
          data.year < currentTime.year) {
        data.taskState = 'Late';
      }
    }
    _allTasks = dataList;
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
      body: Visibility(
        visible: _allTasks.isNotEmpty,
        replacement: Center(
          child: Text(
            'Empty',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ThemeColors.accentColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.separated(
              itemBuilder: (context, i) {
                return TaskTile(
                  taskTitle: _allTasks[i].title,
                  subTitle: _allTasks[i].subTitle,
                  taskStatus: _allTasks[i].taskState,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AskTaskCompleteConfirmation(
                          title: _allTasks[i].title,
                          subTitle:
                              '[${_allTasks[i].date}/${_allTasks[i].month}/${_allTasks[i].year}] ${_allTasks[i].subTitle}',
                        );
                      },
                    );
                    await _fetch();
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
      ),
    );
  }
}
