import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scheduler/data/entity.dart';
import 'package:scheduler/database_setup.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';
import '../utils/theme_colors.dart';
import 'package:get/get.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _subTitleTEC = TextEditingController();
  final DateTime _currentTime = DateTime.now();
  late int _fromTime;
  late int _toTime;
  late String _fromTime12;
  late String _toTime12;
  late int _toTimeMin;

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

  @override
  void initState() {
    _fromTime = _currentTime.hour;
    _toTime = _currentTime.hour;
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberPicker(
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.black45),
                    selectedTextStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ThemeColors.titleColor),
                    minValue: _currentTime.hour,
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
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: ThemeColors.titleColor),
                      ),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: ThemeColors.titleColor,
                        size: 30,
                      ),
                      Text(
                        '$_fromTime12 to $_toTime12',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: ThemeColors.titleColor),
                      )
                    ],
                  ),
                  NumberPicker(
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.black45),
                      selectedTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ThemeColors.titleColor),
                      minValue: _toTimeMin,
                      maxValue: 24,
                      value: _toTime,
                      onChanged: (i) {
                        _toTime = i;
                        _aMPMClock();
                        setState(() {});
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _titleTEC,
                maxLength: 20,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: ThemeColors.titleColor),
                decoration: const InputDecoration(hintText: 'Title:'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _subTitleTEC,
                maxLines: 4,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: ThemeColors.titleColor),
                decoration:
                    const InputDecoration(hintText: 'Description (optional):'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_titleTEC.text.trim().isNotEmpty) {
                    Entity dataEntity = Entity(
                        title: _titleTEC.text,
                        subTitle:
                            '[$_fromTime12 - $_toTime12] ${_subTitleTEC.text}',
                        fromTime: _fromTime,
                        toTime: _toTime,
                        month: _currentTime.month,
                        year: _currentTime.year,
                        taskState: 'Due',
                        date: _currentTime.day);
                    ScaffoldMessenger.of(context).showSnackBar(
                      _bottomPopUpMessage(
                          text: 'Task is successfully created!',
                          color: Colors.green),
                    );
                    await DatabaseSetup.saveActiveTask(dataEntity);
                    Get.offAll(CommonBottomNavBar());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      _bottomPopUpMessage(
                          text: 'Please give a title to your task!',
                          color: Colors.red),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                ),
                child: const Text('Create Task'),
              )
            ],
          ),
        ),
      ),
    );
  }

  SnackBar _bottomPopUpMessage({required String text, required Color color}) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    );
  }

  @override
  void dispose() {
    _titleTEC.dispose();
    _subTitleTEC.dispose();
    super.dispose();
  }
}
