import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';
import '../utils/theme_colors.dart';
import 'package:get/get.dart';

import '../widgets/bottom_popup_message.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen({
    super.key,
    required this.taskDataModel,
  });

  final TaskDataModel taskDataModel;

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  @override
  void initState() {
    _fromTime = widget.taskDataModel.fromTime;
    _toTime = widget.taskDataModel.toTime;
    _toTimeMin = 0;
    _aMPMClock();
    _titleTEC.text = widget.taskDataModel.title;
    _subTitleTEC.text = widget.taskDataModel.subTitle.split('M] ')[1];
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
                height: 10,
              ),
              _updateTaskButton()
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
  late int _fromTime;
  late int _toTime;
  late String _fromTime12;
  late String _toTime12;
  late int _toTimeMin;

  //---------------------------------------Functions---------------------------------------
  void _aMPMClock() {
    if (_fromTime < 12) {
      if (_fromTime == 0) {
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
    if (_toTime < 12) {
      if (_toTime == 0) {
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
      TaskDataModel updatedData = TaskDataModel(
          iD: widget.taskDataModel.iD,
          title: _titleTEC.text,
          subTitle: '[$_fromTime12 - $_toTime12] ${_subTitleTEC.text}',
          fromTime: _fromTime,
          toTime: _toTime,
          month: widget.taskDataModel.month,
          year: widget.taskDataModel.year,
          taskState: 'Due',
          date: widget.taskDataModel.date);
      ScaffoldMessenger.of(context).showSnackBar(
        bottomPopupMessage(
            text: 'Task is successfully edited!', color: Colors.green),
      );
      await LocalDatabase.editActiveTask(updatedData);
      Get.offAll(() => CommonBottomNavBar());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        bottomPopupMessage(
            text: 'Please set a title to your task!', color: Colors.red),
      );
    }
  }

  //---------------------------------------Widgets---------------------------------------
  ElevatedButton _updateTaskButton() {
    return ElevatedButton(
      onPressed: _onCompleted,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
      ),
      child: const Text('Update Task'),
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
          minValue: 0,
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
}
