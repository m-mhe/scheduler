import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/focus_session_data_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:scheduler/local_database.dart';
import '../utils/theme_colors.dart';

class FocusSessionStaticsScreen extends StatefulWidget {
  const FocusSessionStaticsScreen({super.key});

  @override
  State<FocusSessionStaticsScreen> createState() =>
      _FocusSessionStaticsScreenState();
}

class _FocusSessionStaticsScreenState extends State<FocusSessionStaticsScreen> {
  List<FocusSessionDataModel> _sessions = [];
  final DateTime _currentDateTime = DateTime.now();
  double _todayTotalHour = 0.0;
  int _workTask = 0;
  int _codingTask = 0;
  int _studyTask = 0;
  int _exerciseTask = 0;
  int _otherTask = 0;
  int _totalTask = 0;
  int _firstDay = 0;
  int _secondDay = 0;
  int _thirdDay = 0;
  int _fourthDay = 0;
  int _fifthDay = 0;
  int _sixthDay = 0;
  int _seventhDay = 0;
  int _theLargestNumberInTrends = 0;

  Future<void> _fetch() async {
    _sessions = await LocalDatabase.fetchFromFocusSessionDB();
    for (FocusSessionDataModel session in _sessions) {
      if (session.dateTime.difference(_currentDateTime).inDays == 0) {
        _firstDay = _firstDay + session.minutes;
        if (session.dateTime.day == _currentDateTime.day) {
          _todayTotalHour = _todayTotalHour + (session.minutes / 60);
        }
      } else if (session.dateTime.difference(_currentDateTime).inDays == -1) {
        _secondDay = _secondDay + session.minutes;
      } else if (session.dateTime.difference(_currentDateTime).inDays == -2) {
        _thirdDay = _thirdDay + session.minutes;
      } else if (session.dateTime.difference(_currentDateTime).inDays == -3) {
        _fourthDay = _fourthDay + session.minutes;
      } else if (session.dateTime.difference(_currentDateTime).inDays == -4) {
        _fifthDay = _fifthDay + session.minutes;
      } else if (session.dateTime.difference(_currentDateTime).inDays == -5) {
        _sixthDay = _sixthDay + session.minutes;
      } else if (session.dateTime.difference(_currentDateTime).inDays == -6) {
        _seventhDay = _seventhDay + session.minutes;
      }
      if (session.taskType == 'Work') {
        _workTask = _workTask + session.minutes;
      } else if (session.taskType == 'Study') {
        _studyTask = _studyTask + session.minutes;
      } else if (session.taskType == 'Exercise') {
        _exerciseTask = _exerciseTask + session.minutes;
      } else if (session.taskType == 'Coding') {
        _codingTask = _codingTask + session.minutes;
      } else {
        _otherTask = _otherTask + session.minutes;
      }
    }
    _theLargestNumberInTrends = ([
      _firstDay,
      _secondDay,
      _thirdDay,
      _fourthDay,
      _fifthDay,
      _sixthDay,
      _seventhDay
    ].reduce(max));
    if (_todayTotalHour > 3) {
      _todayTotalHour = 3;
    }
    _totalTask =
        _workTask + _studyTask + _codingTask + _exerciseTask + _otherTask;
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
      backgroundColor:
          Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.secondThemeSecond,
      appBar: AppBar(
        title: Text(
          'Focus Stats',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Get.isDarkMode ? ThemeColors.darkAccent : Colors.white),
        ),
        backgroundColor:
            Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.secondThemeMain,
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Get.isDarkMode
                  ? const Icon(Icons.dark_mode_rounded)
                  : const Icon(Icons.dark_mode_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.sizeOf(context).width / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Get.isDarkMode
                            ? Colors.transparent
                            : ThemeColors.lightColor,
                        spreadRadius: 1,
                        blurRadius: 7),
                  ],
                ),
                child: Center(
                  child: SleekCircularSlider(
                    initialValue: _todayTotalHour,
                    min: 0,
                    max: 3,
                    appearance: CircularSliderAppearance(
                        animDurationMultiplier: 2.5,
                        spinnerMode: false,
                        size: MediaQuery.sizeOf(context).width / 1.6,
                        angleRange: 360,
                        startAngle: 270,
                        customWidths: CustomSliderWidths(
                          trackWidth: 15,
                          progressBarWidth: 15,
                          handlerSize: 0,
                        ),
                        customColors: CustomSliderColors(
                          trackColor: Get.isDarkMode
                              ? ThemeColors.darkMain
                              : ThemeColors.secondColor,
                          progressBarColor: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.secondThemeMain,
                          hideShadow: true,
                        ),
                        infoProperties: InfoProperties(
                          topLabelText: 'Daily Goal',
                          topLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.secondThemeMain,
                                  ),
                          modifier: (v) {
                            return '${v.toStringAsFixed(1)} h';
                          },
                          mainLabelStyle: TextStyle(
                            color: Get.isDarkMode
                                ? ThemeColors.darkAccent
                                : ThemeColors.secondThemeMain,
                            fontSize: 28,
                          ),
                          bottomLabelText:
                              '${(3 - _todayTotalHour).toStringAsFixed(1)} hours left',
                          bottomLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.secondThemeMain,
                                  ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 1.65,
                    height: MediaQuery.sizeOf(context).width / 1.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode
                          ? ThemeColors.darkSecond
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Get.isDarkMode
                                ? Colors.transparent
                                : ThemeColors.lightColor,
                            spreadRadius: 1,
                            blurRadius: 7),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Visibility(
                        visible: !(_totalTask == 0),
                        replacement: Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? ThemeColors.darkAccent
                                    : ThemeColors.secondThemeMain,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        child: PieChart(
                          PieChartData(
                              centerSpaceColor: Get.isDarkMode
                                  ? ThemeColors.darkSecond
                                  : Colors.white,
                              sections: [
                                PieChartSectionData(
                                  showTitle: false,
                                  title: 'Study',
                                  value: _studyTask.toDouble(),
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkBlue
                                      : ThemeColors.secondThemeMain,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  title: 'Work',
                                  value: _workTask.toDouble(),
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkBlue.withOpacity(0.8)
                                      : ThemeColors.secondThemeAccent,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  title: 'Exercise',
                                  value: _exerciseTask.toDouble(),
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkBlue.withOpacity(0.6)
                                      : ThemeColors.secondColor,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  title: 'Coding',
                                  value: _codingTask.toDouble(),
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkBlue.withOpacity(0.4)
                                      : ThemeColors.secondColor
                                          .withOpacity(0.6),
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  title: 'Other',
                                  value: _otherTask.toDouble(),
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkBlue.withOpacity(0.3)
                                      : ThemeColors.secondThemeSecond,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width -
                        ((MediaQuery.sizeOf(context).width / 1.65) + 30),
                    height: MediaQuery.sizeOf(context).width / 1.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode
                          ? ThemeColors.darkSecond
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Get.isDarkMode
                                ? Colors.transparent
                                : ThemeColors.lightColor,
                            spreadRadius: 1,
                            blurRadius: 7),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: Get.isDarkMode
                                    ? ThemeColors.darkBlue
                                    : ThemeColors.secondThemeMain,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Study(${((_studyTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                            : ThemeColors.secondThemeMain),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: Get.isDarkMode
                                    ? ThemeColors.darkBlue.withOpacity(0.8)
                                    : ThemeColors.secondThemeAccent,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Work(${((_workTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                            : ThemeColors.secondThemeMain),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: Get.isDarkMode
                                    ? ThemeColors.darkBlue.withOpacity(0.6)
                                    : ThemeColors.secondColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Exercise(${((_exerciseTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                            : ThemeColors.secondThemeMain),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: Get.isDarkMode
                                    ? ThemeColors.darkBlue.withOpacity(0.4)
                                    : ThemeColors.secondColor.withOpacity(0.6),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Coding(${((_codingTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                            : ThemeColors.secondThemeMain),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: Get.isDarkMode
                                    ? ThemeColors.darkBlue.withOpacity(0.3)
                                    : ThemeColors.secondThemeSecond,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Other(${((_otherTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                            : ThemeColors.secondThemeMain),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: (MediaQuery.sizeOf(context).width / 1.8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Get.isDarkMode
                            ? Colors.transparent
                            : ThemeColors.lightColor,
                        spreadRadius: 1,
                        blurRadius: 7),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Trends in past 7 days',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Get.isDarkMode
                                ? ThemeColors.darkAccent
                                : ThemeColors.secondThemeMain),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: LineChart(
                          LineChartData(
                              borderData: FlBorderData(
                                  show: false,
                                  border: Border.all(
                                    color: ThemeColors.secondThemeAccent,
                                    width: 2.0,
                                  )),
                              minX: 1,
                              maxX: 7,
                              minY: 0,
                              maxY: (_theLargestNumberInTrends +
                                  (_theLargestNumberInTrends / 10)),
                              lineBarsData: [
                                LineChartBarData(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.secondThemeMain,
                                    isCurved: true,
                                    preventCurveOverShooting: true,
                                    belowBarData: BarAreaData(
                                        color: Get.isDarkMode
                                            ? ThemeColors.darkAccent
                                                .withOpacity(0.2)
                                            : ThemeColors.secondColor
                                                .withOpacity(0.9),
                                        show: true),
                                    spots: [
                                      FlSpot(1, _seventhDay.toDouble()),
                                      FlSpot(2, _sixthDay.toDouble()),
                                      FlSpot(3, _fifthDay.toDouble()),
                                      FlSpot(4, _fourthDay.toDouble()),
                                      FlSpot(5, _thirdDay.toDouble()),
                                      FlSpot(6, _secondDay.toDouble()),
                                      FlSpot(7, _firstDay.toDouble()),
                                    ]),
                              ],
                              titlesData: FlTitlesData(
                                  leftTitles: const AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  rightTitles: const AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  topTitles: const AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (double dayNumber,
                                        TitleMeta titleMeta) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Text(
                                          (dayNumber - 8)
                                              .toStringAsFixed(0)
                                              .split('')[1],
                                          style: TextStyle(
                                              color: Get.isDarkMode
                                                  ? ThemeColors.darkAccent
                                                  : ThemeColors
                                                      .secondThemeMain),
                                        ),
                                      );
                                    },
                                  ))),
                              gridData: const FlGridData(show: false)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
