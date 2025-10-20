import 'package:flutter/material.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/ask_task_complete_confirmation.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/theme_colors.dart';
import '../widgets/ask_for_edit_confirmation.dart';
import '../widgets/task_tile.dart';
import 'create_task_screen.dart';
import 'package:get/get.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    _fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _calenderView(context),
          _taskView(context),
        ],
      ),
      floatingActionButton: _taskAddingButton(),
    );
  }

  //---------------------------------------Variables---------------------------------------
  final List<TaskDataModel> _allTasks = [];
  DateTime _currentSelectedDateTime = DateTime.now();

  //---------------------------------------Functions---------------------------------------
  Future<void> _fetch() async {
    final DateTime currentTime = DateTime.now();
    _allTasks.clear();
    List<TaskDataModel> dataList = await LocalDatabase.fetchFromActiveDB();
    for (TaskDataModel data in dataList) {
      if (data.date == _currentSelectedDateTime.day &&
          data.month == _currentSelectedDateTime.month &&
          data.year == _currentSelectedDateTime.year) {
        if (currentTime.isAfter(
            DateTime(data.year, data.month, data.date, (data.toTime + 1)))) {
          data.taskState = 'Late';
        }
        _allTasks.add(data);
      }
    }
    setState(() {});
  }

  //---------------------------------------Widgets---------------------------------------
  Expanded _taskView(BuildContext context) {
    return Expanded(
      child: Visibility(
        visible: _allTasks.isNotEmpty,
        replacement: Center(
          child: Text(
            textAlign: TextAlign.center,
            'No task for the day.\nClick + to create a task',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Get.isDarkMode
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
                  onTapForComplete: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AskTaskCompleteConfirmation(
                          title: _allTasks[i].title,
                          subTitle:
                              '[${_allTasks[i].date}/${_allTasks[i].month}/${_allTasks[i].year}] ${_allTasks[i].subTitle}',
                          iD: _allTasks[i].iD ?? 0,
                        );
                      },
                    );
                    await _fetch();
                  },
                  onTapForEdit: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AskForEditConfirmation(
                              taskDataModel: _allTasks[i]);
                        });
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

  TableCalendar<dynamic> _calenderView(BuildContext context) {
    return TableCalendar(
      rowHeight: MediaQuery.sizeOf(context).height / 15,
      onDaySelected: (DateTime selectedDate, DateTime focusDate) {
        _currentSelectedDateTime = selectedDate;
        _fetch();
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
            color:
                Get.isDarkMode ? ThemeColors.darkBlue : ThemeColors.accentColor,
            shape: BoxShape.circle),
        todayTextStyle: TextStyle(
          color: Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
        ),
        disabledTextStyle: TextStyle(
          color: Get.isDarkMode ? Colors.white30 : Colors.black26,
        ),
      ),
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days:73050)),
      focusedDay: _currentSelectedDateTime,
      currentDay: _currentSelectedDateTime,
    );
  }

  FloatingActionButton _taskAddingButton() {
    return FloatingActionButton(
      backgroundColor:
          Get.isDarkMode ? ThemeColors.darkBlue : ThemeColors.accentColor,
      foregroundColor:
          Get.isDarkMode ? ThemeColors.darkSecond : ThemeColors.lightColor,
      onPressed: () {
        final DateTime currentTime = DateTime.now();
        if (currentTime.day == _currentSelectedDateTime.day &&
            currentTime.month == _currentSelectedDateTime.month &&
            currentTime.year == _currentSelectedDateTime.year) {
          Get.to(() => CreateTaskScreen(
                taskTime: currentTime,
              ));
        } else {
          Get.to(() => CreateTaskScreen(
                taskTime: _currentSelectedDateTime,
              ));
        }
      },
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
