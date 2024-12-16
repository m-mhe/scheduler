import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/theme_colors.dart';
import '../widgets/bottom_popup_message.dart';

class TaskPostponeScreen extends StatefulWidget {
  const TaskPostponeScreen({super.key, required this.taskDataModel});

  final TaskDataModel taskDataModel;

  @override
  State<TaskPostponeScreen> createState() => _TaskPostponeScreenState();
}

class _TaskPostponeScreenState extends State<TaskPostponeScreen> {
  @override
  void initState() {
    _taskDataModel = widget.taskDataModel;
    _currentSelectedDateTime = DateTime(
        _taskDataModel.year, _taskDataModel.month, _taskDataModel.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      body: Column(
        children: [_calenderView(context), _postponeButton()],
      ),
    );
  }

  //---------------------------------------Variables---------------------------------------
  final _currentDateTime = DateTime.now();
  late DateTime _currentSelectedDateTime;
  late final TaskDataModel _taskDataModel;

  //---------------------------------------Functions---------------------------------------
  void _onPostponed() async {
    _taskDataModel.year = _currentSelectedDateTime.year;
    _taskDataModel.month = _currentSelectedDateTime.month;
    _taskDataModel.date = _currentSelectedDateTime.day;
    _taskDataModel.taskState = 'Due';
    ScaffoldMessenger.of(context).showSnackBar(
      bottomPopupMessage(
          text: 'Task is successfully postponed!', color: Colors.green),
    );
    await LocalDatabase.editActiveTask(_taskDataModel);
    Get.offAll(() => CommonBottomNavBar());
  }

  //---------------------------------------Widgets---------------------------------------
  Padding _postponeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        onPressed: _onPostponed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
        ),
        child: const Text('Postpone Task'),
      ),
    );
  }

  TableCalendar<dynamic> _calenderView(BuildContext context) {
    return TableCalendar(
      rowHeight: MediaQuery.sizeOf(context).height / 15,
      onDaySelected: (DateTime selectedDate, DateTime focusDate) {
        _currentSelectedDateTime = selectedDate;
        setState(() {});
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
      firstDay: _currentDateTime.isAfter(_currentSelectedDateTime)
          ? _currentSelectedDateTime
          : _currentDateTime,
      lastDay: DateTime(3024, 11, 5),
      focusedDay: _currentSelectedDateTime,
      currentDay: _currentSelectedDateTime,
    );
  }
}
