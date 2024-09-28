import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scheduler/ui/screens/create_task_screen.dart';

import '../utils/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _chartTouchedIndex = -1;
  DateTime _currentDate = DateTime.now();

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
                        boxShadow: [
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
                                  color: ThemeColors.midColor.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                            boxShadow: [
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
                                    SizedBox(
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
                                          ThemeColors.midColor.withOpacity(0.3),
                                    ),
                                    SizedBox(
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
                            boxShadow: [
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
                              '${_currentDate.day}/${_currentDate.month}/${_currentDate.year}',
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
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeColors.lightColor.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.lightColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.separated(
                        itemBuilder: (contex, i) {
                          return ListTile(
                            title: Text(
                              'Task Title',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ThemeColors.titleColor,
                                  ),
                            ),
                            subtitle: Text(
                              '${_currentDate.hour}:${_currentDate.minute}:${_currentDate.second}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: ThemeColors.titleColor,
                                  ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      backgroundColor: ThemeColors.lightColor,
                                      title: Text(
                                        'Have you completed this task?',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: ThemeColors.titleColor,
                                            ),
                                      ),
                                      content: Text(
                                        "If this task is completed then click 'Yes', Otherwise click 'No'. You can cancel this task by Deleting it.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: ThemeColors.titleColor,
                                            ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(Icons.delete_outline),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Late'),
                            ),
                          );
                        },
                        separatorBuilder: (contex, i) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 40),
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
                    color: ThemeColors.secondColor.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.lightColor.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.separated(
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text(
                              'Task Title',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ThemeColors.titleColor,
                                  ),
                            ),
                            subtitle: Text(
                              '${_currentDate.hour}:${_currentDate.minute}:${_currentDate.second}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: ThemeColors.titleColor,
                                  ),
                            ),
                            trailing: ElevatedButton(
                                onPressed: () {}, child: Text('Due')),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: 40),
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
        child: Icon(Icons.add),
      ),
    );
  }
}
