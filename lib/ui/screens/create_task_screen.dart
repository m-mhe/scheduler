import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';
import '../utils/theme_colors.dart';
import 'package:get/get.dart';

import '../widgets/bottom_popup_message.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key, required this.taskTime});

  final DateTime taskTime;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  void initState() {
    _taskTime = widget.taskTime;
    _fromTime = _taskTime.hour;
    _toTime = _taskTime.hour;
    _toTimeMin = _toTime;
    _aMPMClock();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              _timeSelector(context),
              const SizedBox(
                height: 10,
              ),
              _titleTextField(context),
              _descriptionTextField(context),
              const SizedBox(
                height: 3,
              ),
              _yearRepeatButton(),
              _createTaskButton()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEC.dispose();
    _subTitleTEC.dispose();
    super.dispose();
  }

  //---------------------------------------Variables---------------------------------------
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _subTitleTEC = TextEditingController();
  late final DateTime _taskTime;
  late int _fromTime;
  late int _toTime;
  late String _fromTime12;
  late String _toTime12;
  late int _toTimeMin;
  bool _isYearlyRepeatOn = false;

  //---------------------------------------Functions---------------------------------------
  void _aMPMClock() {
    if (_fromTime < 12 || _fromTime == 24) {
      if (_fromTime == 0 || _fromTime == 24) {
        _fromTime12 = '12 AM';
      } else {
        _fromTime12 = '$_fromTime AM';
      }
    } else {
      if (_fromTime == 12) {
        _fromTime12 = '$_fromTime PM';
      } else {
        _fromTime12 = '${_fromTime - 12} PM';
      }
    }
    if (_toTime < 12 || _toTime == 24) {
      if (_toTime == 0 || _toTime == 24) {
        _toTime12 = '12 AM';
      } else {
        _toTime12 = '$_toTime AM';
      }
    } else {
      if (_toTime == 12) {
        _toTime12 = '$_toTime PM';
      } else {
        _toTime12 = '${_toTime - 12} PM';
      }
    }
  }

  Future<void> _onCompleted() async {
    if (_titleTEC.text.trim().isNotEmpty) {
      if (_isYearlyRepeatOn) {
        ScaffoldMessenger.of(context).showSnackBar(
          bottomPopupMessage(
              text: 'Task is successfully created!', color: Colors.green),
        );
        for (int i = 0; i < 60; i++) {
          TaskDataModel dataEntity = TaskDataModel(
              title: _titleTEC.text,
              subTitle: '[$_fromTime12 - $_toTime12] ${_subTitleTEC.text}',
              fromTime: _fromTime,
              toTime: _toTime,
              month: _taskTime.month,
              year: (_taskTime.year + i),
              taskState: 'Due',
              date: _taskTime.day);
          await LocalDatabase.saveActiveTask(dataEntity);
        }
        Get.offAll(() => CommonBottomNavBar());
      } else {
        TaskDataModel dataEntity = TaskDataModel(
            title: _titleTEC.text,
            subTitle: '[$_fromTime12 - $_toTime12] ${_subTitleTEC.text}',
            fromTime: _fromTime,
            toTime: _toTime,
            month: _taskTime.month,
            year: _taskTime.year,
            taskState: 'Due',
            date: _taskTime.day);
        ScaffoldMessenger.of(context).showSnackBar(
          bottomPopupMessage(
              text: 'Task is successfully created!', color: Colors.green),
        );
        await LocalDatabase.saveActiveTask(dataEntity);
        Get.offAll(() => CommonBottomNavBar());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        bottomPopupMessage(
            text: 'Please give a title to your task!', color: Colors.red),
      );
    }
  }

  //---------------------------------------Widgets---------------------------------------
  ElevatedButton _createTaskButton() {
    return ElevatedButton(
      onPressed: _onCompleted,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),//Size(double width, double height)
      ),
      child: const Text('Create Task'),
    );
  }

  TextField _descriptionTextField(BuildContext context) {
    return TextField(
      controller: _subTitleTEC,
      maxLines: 5,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color:
              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.titleColor),
      decoration: const InputDecoration(hintText: 'Description (optional):'),
    );
  }

  TextField _titleTextField(BuildContext context) {
    return TextField(
      controller: _titleTEC,
      textInputAction: TextInputAction.next,
      maxLength: 20,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color:
              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.titleColor),
      decoration: const InputDecoration(hintText: 'Title:'),
    );
  }

  Row _timeSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NumberPicker(
          textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Get.isDarkMode ? ThemeColors.accentColor : Colors.black45),
          selectedTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor),
          minValue: _taskTime.hour,
          maxValue: 24,
          value: _fromTime,
          onChanged: (i) {
            _fromTime = i;
            _toTimeMin = i;
            _toTime = i;
            _aMPMClock();
            setState(() {});
          },
        ),
        Column(
          children: [
            Text(
              'Time',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.titleColor),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor,
              size: 30,
            ),
            Text(
              '$_fromTime12 to $_toTime12',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.titleColor),
            )
          ],
        ),
        NumberPicker(
            textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color:
                    Get.isDarkMode ? ThemeColors.accentColor : Colors.black45),
            selectedTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Get.isDarkMode
                    ? ThemeColors.darkAccent
                    : ThemeColors.titleColor),
            minValue: _toTimeMin,
            maxValue: 24,
            value: _toTime,
            onChanged: (i) {
              _toTime = i;
              _aMPMClock();
              setState(() {});
            }),
      ],
    );
  }

  InkWell _yearRepeatButton() {
    return InkWell(
      onTap: () {
        if (_isYearlyRepeatOn) {
          _isYearlyRepeatOn = false;
        } else {
          _isYearlyRepeatOn = true;
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? _isYearlyRepeatOn
                          ? ThemeColors.darkAccent
                          : Colors.transparent
                      : _isYearlyRepeatOn
                          ? ThemeColors.accentColor
                          : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Get.isDarkMode
                          ? ThemeColors.darkAccent
                          : ThemeColors.accentColor,
                      width: 2)),
            ),
            const SizedBox(
              width: 7.5,
            ),
            Text(
              'Repeat in every year',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.accentColor),
            )
          ],
        ),
      ),
    );
  }
}
