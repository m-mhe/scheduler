import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
                              color: ThemeColors.lightColor.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7),
                        ],
                      ),
                      height: 250,
                      width: MediaQuery.sizeOf(context).width / 1.7,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
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
                                  title: '32%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                  showTitle: _chartTouchedIndex == 0,
                                  value: 32,
                                  color: ThemeColors.titleColor,
                                ),
                                PieChartSectionData(
                                  title: '10%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                  showTitle: _chartTouchedIndex == 1,
                                  value: 10,
                                  color:
                                      ThemeColors.accentColor.withOpacity(0.9),
                                ),
                                PieChartSectionData(
                                  title: '20%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.white),
                                  showTitle: _chartTouchedIndex == 2,
                                  value: 20,
                                  color:
                                      ThemeColors.lightColor.withOpacity(0.7),
                                ),
                                PieChartSectionData(
                                  title: '20%',
                                  titleStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: Colors.black45),
                                  showTitle: _chartTouchedIndex == 3,
                                  value: 20,
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
                                  color:
                                      ThemeColors.lightColor.withOpacity(0.3),
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
                                      color: ThemeColors.titleColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                     Text('Completed',
                                       style: Theme.of(context)
                                           .textTheme
                                           .labelSmall!
                                           .copyWith(color: ThemeColors.titleColor),)
                                  ],
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: ThemeColors.accentColor
                                          .withOpacity(0.9),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                     Text('Due',
                                       style: Theme.of(context)
                                           .textTheme
                                           .labelSmall!
                                           .copyWith(color: ThemeColors.titleColor),)
                                  ],
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: ThemeColors.lightColor
                                          .withOpacity(0.7),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                     Text('Late',
                                       style: Theme.of(context)
                                           .textTheme
                                           .labelSmall!
                                           .copyWith(color: ThemeColors.titleColor),)
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
                                          .copyWith(color: ThemeColors.titleColor),
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
                                color: ThemeColors.lightColor.withOpacity(0.3),
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
                                  .copyWith(color: ThemeColors.titleColor, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
