import 'package:flutter/material.dart';
import 'package:scheduler/data/old_task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/task_tile.dart';
import '../utils/theme_colors.dart';
import 'package:get/get.dart';

class PreviousTasks extends StatefulWidget {
  const PreviousTasks({super.key});

  @override
  State<PreviousTasks> createState() => _PreviousTasksState();
}

class _PreviousTasksState extends State<PreviousTasks> {
  List<OldTaskDataModel> _allTasks = [];

  Future<void> _fetch() async {
    _allTasks = await LocalDatabase.fetchFromInactiveDB();
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
                .copyWith(color: Get.isDarkMode
                ? ThemeColors.darkAccent
                : ThemeColors.accentColor),
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
      ),
    );
  }
}
