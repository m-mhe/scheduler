import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/focus_session_data_model.dart';
import 'package:scheduler/local_cache.dart';
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
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              _dailyGoalSection(context),
              const SizedBox(
                height: 10,
              ),
              _pieChartSection(context),
              const SizedBox(
                height: 10,
              ),
              _graphSection(context),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------Variables----------------------------------------------
  List<FocusSessionDataModel> _sessions = [];
  DateTime _currentDateTime = DateTime.now();
  double _todayTotalHour = 0.0;
  double _dailyGoal = 3;
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

  //----------------------------------------------Function----------------------------------------------
  Future<void> _fetch() async {
    _currentDateTime = DateTime.now();
    _todayTotalHour = 0.0;
    _workTask = 0;
    _codingTask = 0;
    _studyTask = 0;
    _exerciseTask = 0;
    _otherTask = 0;
    _totalTask = 0;
    _firstDay = 0;
    _secondDay = 0;
    _thirdDay = 0;
    _fourthDay = 0;
    _fifthDay = 0;
    _sixthDay = 0;
    _seventhDay = 0;
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
    _dailyGoal = await LocalCache.getDailyHourGoal() ?? 3;
    _theLargestNumberInTrends = ([
      _firstDay,
      _secondDay,
      _thirdDay,
      _fourthDay,
      _fifthDay,
      _sixthDay,
      _seventhDay
    ].reduce(max));
    if (_todayTotalHour > _dailyGoal) {
      _todayTotalHour = _dailyGoal.toDouble();
    }
    _totalTask =
        _workTask + _studyTask + _codingTask + _exerciseTask + _otherTask;
    setState(() {});
  }

  //----------------------------------------------Widgets----------------------------------------------
  Container _graphSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: (MediaQuery.sizeOf(context).width / 1.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
        boxShadow: [
          BoxShadow(
              color:
                  Get.isDarkMode ? Colors.transparent : ThemeColors.lightColor,
              spreadRadius: 1,
              blurRadius: 7),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              'Trends in past 168 hours',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.secondThemeMain),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  ? ThemeColors.darkAccent.withAlpha(51)
                                  : ThemeColors.secondColor.withAlpha(229),
                              show: true),
                          spots: [
                            FlSpot(1, _firstDay.toDouble()),
                            FlSpot(2, _secondDay.toDouble()),
                            FlSpot(3, _thirdDay.toDouble()),
                            FlSpot(4, _fourthDay.toDouble()),
                            FlSpot(5, _fifthDay.toDouble()),
                            FlSpot(6, _sixthDay.toDouble()),
                            FlSpot(7, _seventhDay.toDouble()),
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
                          getTitlesWidget:
                              (double dayNumber, TitleMeta titleMeta) {
                            return Padding(
                              padding: const EdgeInsets.all(3),
                              child: Text(
                                (dayNumber).toStringAsFixed(0),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.secondThemeMain),
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
    );
  }

  Row _pieChartSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width / 1.65,
          height: MediaQuery.sizeOf(context).width / 1.65,
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
                    centerSpaceColor:
                        Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
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
                            ? ThemeColors.darkBlue.withAlpha(204)
                            : ThemeColors.secondThemeAccent,
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        title: 'Exercise',
                        value: _exerciseTask.toDouble(),
                        color: Get.isDarkMode
                            ? ThemeColors.darkBlue.withAlpha(153)
                            : ThemeColors.secondColor,
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        title: 'Coding',
                        value: _codingTask.toDouble(),
                        color: Get.isDarkMode
                            ? ThemeColors.darkBlue.withAlpha(102)
                            : ThemeColors.secondColor.withAlpha(153),
                      ),
                      PieChartSectionData(
                        showTitle: false,
                        title: 'Other',
                        value: _otherTask.toDouble(),
                        color: Get.isDarkMode
                            ? ThemeColors.darkBlue.withAlpha(76)
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
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                          ? ThemeColors.darkBlue.withAlpha(204)
                          : ThemeColors.secondThemeAccent,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Work(${((_workTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                          ? ThemeColors.darkBlue.withAlpha(93)
                          : ThemeColors.secondColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Exercise(${((_exerciseTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                          ? ThemeColors.darkBlue.withAlpha(102)
                          : ThemeColors.secondColor.withAlpha(153),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Coding(${((_codingTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                          ? ThemeColors.darkBlue.withAlpha(76)
                          : ThemeColors.secondThemeSecond,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Other(${((_otherTask / _totalTask) * 100).toStringAsFixed(0)}%)',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
    );
  }

  Container _dailyGoalSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).width / 1.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
        boxShadow: [
          BoxShadow(
              color:
                  Get.isDarkMode ? Colors.transparent : ThemeColors.lightColor,
              spreadRadius: 1,
              blurRadius: 7),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Center(
            child: SleekCircularSlider(
              initialValue: _todayTotalHour,
              min: 0,
              max: _dailyGoal.toDouble(),
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
                        _todayTotalHour==_dailyGoal?'Completed':'${(_dailyGoal - _todayTotalHour).toStringAsFixed(1)} hours left',
                    bottomLabelStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.secondThemeMain,
                            ),
                  )),
            ),
          ),
          IconButton(
              onPressed: () {
                final TextEditingController dailyGoalTEC =
                    TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: Get.isDarkMode
                            ? ThemeColors.darkMain
                            : ThemeColors.lightColor,
                        title: Text(
                          'Set your daily goal',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.titleColor,
                                  ),
                        ),
                        content: TextField(
                          controller: dailyGoalTEC,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color:
                              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.titleColor),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Daily Goal:', suffixText: 'hour'),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                              onPressed: () async {
                                double? data =
                                double.tryParse(dailyGoalTEC.text.trim());
                                if (data != null && data > 0) {
                                  await LocalCache.saveDailyHourGoal(data);
                                  await _fetch();
                                  Get.back();
                                } else {
                                  Get.back();
                                }
                              },
                              child: const Text('Save')),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.edit,
                color: Get.isDarkMode
                    ? ThemeColors.darkAccent
                    : ThemeColors.secondThemeMain,
              ))
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
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
              final bool isDarkMode = Get.isDarkMode;
              Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
              LocalCache.saveTheme(isDark: !isDarkMode);
            },
            icon: Get.isDarkMode
                ? const Icon(Icons.dark_mode_rounded)
                : const Icon(Icons.dark_mode_outlined))
      ],
    );
  }
}
