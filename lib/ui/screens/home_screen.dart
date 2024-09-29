import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/entity.dart';
import 'package:scheduler/database_setup.dart';
import 'package:scheduler/ui/screens/create_task_screen.dart';
import '../utils/theme_colors.dart';
import '../widgets/ask_task_complete_confirmation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _chartTouchedIndex = -1;
  final DateTime _currentTime = DateTime.now();
  final List<Entity> _currentTasks = [];
  List<Entity> _allTasks = [];

  Future<void> fetch() async {
    List<Entity> dataList = await DatabaseSetup.fetchFromActiveDB();
    for (Entity data in dataList) {
      if (data.fromTime <= _currentTime.hour ||
          data.date < _currentTime.day ||
          data.month < _currentTime.month ||
          data.year < _currentTime.year) {
        _currentTasks.add(data);
      }
    }
    _allTasks = dataList;
    setState(() {});
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ThemeColors.lightColor,
                              spreadRadius: 1,
                              blurRadius: 7),
                        ],
                      ),
                      height: 250,
                      width: MediaQuery.sizeOf(context).width / 1.7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (event, response) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      response == null ||
                                      response.touchedSection == null) {
                                    _chartTouchedIndex = -1;
                                    return;
                                  }
                                  _chartTouchedIndex = response
                                      .touchedSection!.touchedSectionIndex;
                                });
                              }),
                              sections: [
                                PieChartSectionData(
                                  title: '66%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                  showTitle: true,
                                  value: 66,
                                  color: ThemeColors.accentColor,
                                ),
                                PieChartSectionData(
                                  title: '34%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: ThemeColors.titleColor),
                                  showTitle: _chartTouchedIndex == 1,
                                  value: 34,
                                  color: ThemeColors.midColor.withOpacity(0.4),
                                ),
                              ],
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: ThemeColors.lightColor,
                                  spreadRadius: 1,
                                  blurRadius: 7),
                            ],
                          ),
                          height: 170,
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
                                      color: ThemeColors.accentColor,
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
                                              color: ThemeColors.titleColor),
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
                                      color:
                                          ThemeColors.midColor.withOpacity(0.4),
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
                                              color: ThemeColors.titleColor),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: ThemeColors.lightColor,
                                spreadRadius: 1,
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          height: 70,
                          width: MediaQuery.sizeOf(context).width -
                              ((MediaQuery.sizeOf(context).width / 1.7) + 30),
                          child: Center(
                            child: Text(
                              '${_currentTime.day}/${_currentTime.month}/${_currentTime.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: ThemeColors.titleColor,
                                      fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  width: double.maxFinite,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColors.lightColor,
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.lightColor.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Visibility(
                    visible: _currentTasks.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        'You Have No Current Task',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: ThemeColors.accentColor),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.separated(
                          itemBuilder: (context, i) {
                            return _taskList(
                                buildContext: context,
                                taskTitle: _currentTasks[i].title,
                                taskSubTitle: _currentTasks[i].subTitle,
                                taskState: _currentTasks[i].taskState);
                          },
                          separatorBuilder: (context, i) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: _currentTasks.length),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColors.secondColor.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.lightColor.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Visibility(
                    visible: _allTasks.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        'You Have No Task',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: ThemeColors.accentColor),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.separated(
                          itemBuilder: (context, i) {
                            return _taskList(
                                buildContext: context,
                                taskTitle: _allTasks[i].title,
                                taskSubTitle: _allTasks[i].subTitle,
                                taskState: _allTasks[i].taskState);
                          },
                          separatorBuilder: (context, i) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: _allTasks.length),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const CreateTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListTile _taskList(
      {required BuildContext buildContext,
      required String taskTitle,
      required String taskSubTitle,
      required taskState}) {
    return ListTile(
      title: Text(
        taskTitle,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: ThemeColors.titleColor,
            ),
      ),
      subtitle: Text(
        taskSubTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: ThemeColors.titleColor,
            ),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AskTaskCompleteConfirmation();
            },
          );
        },
        child: Text(taskState),
      ),
    );
  }
}
