import 'package:audioplayers/audioplayers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/data/old_task_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/screens/create_task_screen.dart';
import 'package:scheduler/ui/screens/focus_session_screen.dart';
import 'package:scheduler/ui/widgets/ask_for_edit_confirmation.dart';
import '../utils/theme_colors.dart';
import '../widgets/ask_task_complete_confirmation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _fetch();
    _refreshScreen();
    _audioPlayer.play(
      AssetSource('audio/clock.mp3'),
      volume: 0,
    );
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _taskStatsAndFocusScreenNav(context),
            _currentTaskWidget(context),
            _allTaskWidget(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateTaskScreen(
                taskTime: DateTime.now(),
              ));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  @override
  dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  //-------------------------------Variables-------------------------------
  List<OldTaskDataModel> _oldTaskList = [];
  double _totalCanceled = 0;
  double _totalCompleted = 0;
  int _chartTouchedIndex = -1;
  late DateTime _currentTime;
  final List<TaskDataModel> _currentTasks = [];
  final List<TaskDataModel> _allTasks = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  //-------------------------------Functions-------------------------------
  Future<void> _fetch() async {
    _currentTime = DateTime.now();
    _currentTasks.clear();
    _allTasks.clear();
    List<TaskDataModel> dataList = await LocalDatabase.fetchFromActiveDB();
    for (TaskDataModel data in dataList) {
      if (_currentTime.isAfter(
          DateTime(data.year, data.month, data.date, (data.fromTime)))) {
        if (_currentTime.isAfter(
            DateTime(data.year, data.month, data.date, (data.toTime + 1)))) {
          data.taskState = 'Late';
        }
        _currentTasks.add(data);
      }
      if (data.date == _currentTime.day &&
          data.month == _currentTime.month &&
          data.year == _currentTime.year) {
        _allTasks.add(data);
      }
    }
    await _calculateTask();
    setState(() {});
  }

  Future<void> _refreshScreen() async {
    const bool active = true;
    while (active) {
      final DateTime remainingTimeFrom = DateTime.now();
      final int minuteToWait = (60 - remainingTimeFrom.minute);
      final int secondToMinus = (remainingTimeFrom.second);
      final int totalSecondToWait = ((minuteToWait * 60) - secondToMinus);
      await Future.delayed(Duration(seconds: (totalSecondToWait + 1)));
      await _fetch();
    }
  }

  Future<void> _calculateTask() async {
    _totalCanceled = 0;
    _totalCompleted = 0;
    _oldTaskList = await LocalDatabase.fetchFromInactiveDB();
    for (OldTaskDataModel task in _oldTaskList) {
      if (task.taskState == 'Completed') {
        _totalCompleted++;
      } else {
        _totalCanceled++;
      }
    }
  }

  void _focusSessionTimeSelection() {
    double endTime = 24;
    double breakEndTime = 4;
    final List<int> focusTimes = [
      5,
      10,
      15,
      20,
      25,
      30,
      35,
      40,
      45,
      50,
      55,
      60,
      65,
      70,
      75,
      80,
      85,
      90,
      95,
    ];
    final List<int> breakTimes = [
      5,
      10,
      15,
      20,
      25,
      30,
    ];
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(5),
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor:
                Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
            title: Text(
              'Set time',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Get.isDarkMode
                        ? ThemeColors.darkAccent
                        : ThemeColors.titleColor,
                  ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                    onSelected: (v) {
                      endTime = (focusTimes[v!] - 1).toDouble();
                    },
                    initialSelection: 4,
                    menuHeight: 150,
                    label: Text(
                      'Focus time',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor),
                    ),
                    width: 115,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: 0, label: '${focusTimes[0]} minute'),
                      DropdownMenuEntry(
                          value: 1, label: '${focusTimes[1]} minute'),
                      DropdownMenuEntry(
                          value: 2, label: '${focusTimes[2]} minute'),
                      DropdownMenuEntry(
                          value: 3, label: '${focusTimes[3]} minute'),
                      DropdownMenuEntry(
                          value: 4, label: '${focusTimes[4]} minute'),
                      DropdownMenuEntry(
                          value: 5, label: '${focusTimes[5]} minute'),
                      DropdownMenuEntry(
                          value: 6, label: '${focusTimes[6]} minute'),
                      DropdownMenuEntry(
                          value: 7, label: '${focusTimes[7]} minute'),
                      DropdownMenuEntry(
                          value: 8, label: '${focusTimes[8]} minute'),
                      DropdownMenuEntry(
                          value: 9, label: '${focusTimes[9]} minute'),
                      DropdownMenuEntry(
                          value: 10, label: '${focusTimes[10]} minute'),
                      DropdownMenuEntry(
                          value: 11, label: '${focusTimes[11]} minute'),
                      DropdownMenuEntry(
                          value: 12, label: '${focusTimes[12]} minute'),
                      DropdownMenuEntry(
                          value: 13, label: '${focusTimes[13]} minute'),
                      DropdownMenuEntry(
                          value: 14, label: '${focusTimes[14]} minute'),
                      DropdownMenuEntry(
                          value: 15, label: '${focusTimes[15]} minute'),
                      DropdownMenuEntry(
                          value: 16, label: '${focusTimes[16]} minute'),
                      DropdownMenuEntry(
                          value: 17, label: '${focusTimes[17]} minute'),
                      DropdownMenuEntry(
                          value: 18, label: '${focusTimes[18]} minute'),
                    ]),
                DropdownMenu(
                    onSelected: (v) {
                      breakEndTime = (breakTimes[v!] - 1).toDouble();
                    },
                    initialSelection: 0,
                    menuHeight: 150,
                    label: Text(
                      'Break time',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor),
                    ),
                    width: 107,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: 0, label: '${breakTimes[0]} minute'),
                      DropdownMenuEntry(
                          value: 1, label: '${breakTimes[1]} minute'),
                      DropdownMenuEntry(
                          value: 2, label: '${breakTimes[2]} minute'),
                      DropdownMenuEntry(
                          value: 3, label: '${breakTimes[3]} minute'),
                      DropdownMenuEntry(
                          value: 4, label: '${breakTimes[4]} minute'),
                      DropdownMenuEntry(
                          value: 5, label: '${breakTimes[5]} minute'),
                    ]),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => FocusSessionScreen(
                        endTime: endTime,
                        breakEndTime: breakEndTime,
                      ));
                },
                child: const Text('Start'),
              ),
            ],
          );
        });
  }

  //-------------------------------Widgets-------------------------------
  Expanded _allTaskWidget(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Get.isDarkMode
                ? ThemeColors.darkSecond
                : ThemeColors.secondColor.withAlpha(102),
            boxShadow: [
              BoxShadow(
                color: Get.isDarkMode
                    ? Colors.transparent
                    : ThemeColors.lightColor.withAlpha(102),
                spreadRadius: 1,
                blurRadius: 7,
              ),
            ],
          ),
          child: Visibility(
            visible: _allTasks.isNotEmpty,
            replacement: Center(
              child: Text(
                'No task for the day.',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Get.isDarkMode
                        ? ThemeColors.darkAccent
                        : ThemeColors.accentColor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ListView.separated(
                  itemBuilder: (context, i) {
                    return _taskList(taskDataModel: _allTasks[i]);
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                  itemCount: _allTasks.length),
            ),
          ),
        ),
      ),
    );
  }

  Padding _currentTaskWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 10),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.sizeOf(context).height / 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:
              Get.isDarkMode ? ThemeColors.darkSecond : ThemeColors.lightColor,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Colors.transparent
                  : ThemeColors.lightColor.withAlpha(102),
              spreadRadius: 1,
              blurRadius: 7,
            ),
          ],
        ),
        child: Visibility(
          visible: _currentTasks.isNotEmpty,
          replacement: Center(
            child: Text(
              'Your current tasks will be shown here.\nClick + to create a task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.accentColor),
            ),
          ),
          child: ListView.separated(
              itemBuilder: (context, i) {
                return _taskList(taskDataModel: _currentTasks[i]);
              },
              separatorBuilder: (context, i) {
                return const SizedBox(
                  height: 0,
                );
              },
              itemCount: _currentTasks.length),
        ),
      ),
    );
  }

  Widget _taskStatsAndFocusScreenNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
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
            height: 240,
            width: MediaQuery.sizeOf(context).width / 1.7,
            child: Center(
              child: Visibility(
                visible: _oldTaskList.isNotEmpty,
                replacement: Text(
                  'Complete a task.',
                  style: TextStyle(
                      color: Get.isDarkMode
                          ? ThemeColors.darkAccent
                          : ThemeColors.titleColor,
                      fontWeight: FontWeight.w600),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: PieChart(
                    duration: const Duration(seconds: 2),
                    PieChartData(
                      centerSpaceColor: Get.isDarkMode
                          ? ThemeColors.darkSecond
                          : Colors.white,
                      pieTouchData:
                          PieTouchData(touchCallback: (event, response) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              response == null ||
                              response.touchedSection == null) {
                            _chartTouchedIndex = -1;
                            return;
                          }
                          _chartTouchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        });
                      }),
                      sections: [
                        PieChartSectionData(
                          title:
                              '${((_totalCompleted / (_totalCompleted + _totalCanceled)) * 100).toStringAsFixed(0)}%',
                          titleStyle: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? ThemeColors.darkSecond
                                      : Colors.white),
                          showTitle: true,
                          value: _totalCompleted,
                          color: Get.isDarkMode
                              ? ThemeColors.darkBlue
                              : ThemeColors.accentColor,
                        ),
                        PieChartSectionData(
                          title:
                              '${((_totalCanceled / (_totalCanceled + _totalCompleted)) * 100).toStringAsFixed(2)}%',
                          titleStyle: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white70
                                      : ThemeColors.titleColor),
                          showTitle: _chartTouchedIndex == 1,
                          value: _totalCanceled,
                          color: Get.isDarkMode
                              ? ThemeColors.darkBlue.withAlpha(178)
                              : ThemeColors.midColor.withAlpha(102),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
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
                height: 165,
                width: MediaQuery.sizeOf(context).width -
                    ((MediaQuery.sizeOf(context).width / 1.7) + 30),
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
                                : ThemeColors.accentColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Completed',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.titleColor),
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
                                ? ThemeColors.darkBlue.withAlpha(178)
                                : ThemeColors.midColor.withAlpha(102),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Canceled',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color: Get.isDarkMode
                                        ? ThemeColors.darkAccent
                                        : ThemeColors.titleColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: _focusSessionTimeSelection,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color:
                        Get.isDarkMode ? ThemeColors.darkSecond : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Get.isDarkMode
                            ? Colors.transparent
                            : ThemeColors.lightColor,
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  height: 65,
                  width: MediaQuery.sizeOf(context).width -
                      ((MediaQuery.sizeOf(context).width / 1.7) + 30),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Icon(
                        Icons.alarm_on_rounded,
                        color: Get.isDarkMode
                            ? ThemeColors.darkMain
                            : ThemeColors.lightColor,
                        size: 60,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Start\nfocus session',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Get.isDarkMode
                                ? ThemeColors.darkAccent
                                : ThemeColors.titleColor,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListTile _taskList({required TaskDataModel taskDataModel}) {
    return ListTile(
      title: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AskForEditConfirmation(taskDataModel: taskDataModel);
              });
        },
        child: Text(
          taskDataModel.title.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: taskDataModel.taskState == 'Due'
                    ? Get.isDarkMode
                        ? ThemeColors.darkAccent
                        : ThemeColors.titleColor
                    : Colors.red,
              ),
        ),
      ),
      subtitle: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AskForEditConfirmation(taskDataModel: taskDataModel);
              });
        },
        child: Text(
          taskDataModel.subTitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: taskDataModel.taskState == 'Due'
                    ? Get.isDarkMode
                        ? ThemeColors.darkAccent
                        : ThemeColors.accentColor
                    : Colors.red,
              ),
        ),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: taskDataModel.taskState == 'Due'
              ? Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.accentColor
              : Colors.red,
        ),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AskTaskCompleteConfirmation(
                title: taskDataModel.title,
                subTitle:
                    '[${taskDataModel.date}/${taskDataModel.month}/${taskDataModel.year}] ${taskDataModel.subTitle}',
                iD: taskDataModel.iD!,
              );
            },
          );
          await _fetch();
        },
        child: Text(taskDataModel.taskState),
      ),
    );
  }
}
