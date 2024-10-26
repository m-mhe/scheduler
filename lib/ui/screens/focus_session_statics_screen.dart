import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../utils/theme_colors.dart';

class FocusSessionStaticsScreen extends StatefulWidget {
  const FocusSessionStaticsScreen({super.key});

  @override
  State<FocusSessionStaticsScreen> createState() =>
      _FocusSessionStaticsScreenState();
}

class _FocusSessionStaticsScreenState extends State<FocusSessionStaticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.secondThemeSecond,
      appBar: AppBar(
        title: Text(
          'Focus Statics',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        backgroundColor: ThemeColors.secondThemeMain,
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
              SizedBox(
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
                    initialValue: 2,
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
                          trackColor: ThemeColors.secondColor,
                          progressBarColor: ThemeColors.secondThemeMain,
                          hideShadow: true,
                        ),
                        infoProperties: InfoProperties(
                          topLabelText: 'Daily Goal',
                          topLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: ThemeColors.secondThemeMain,
                                  ),
                          modifier: (v) {
                            return '${v.toStringAsFixed(1)} h';
                          },
                          mainLabelStyle: const TextStyle(
                            color: ThemeColors.secondThemeMain,
                            fontSize: 28,
                          ),
                          bottomLabelText: '1 hours left',
                          bottomLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: ThemeColors.secondThemeMain,
                                  ),
                        )),
                  ),
                ),
              ),
              SizedBox(
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
                      padding: const EdgeInsets.all(15),
                      child: PieChart(
                        PieChartData(centerSpaceColor: Colors.white, sections: [
                          PieChartSectionData(
                            showTitle: false,
                            title: '50%',
                            value: 7,
                            color: ThemeColors.secondThemeMain,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '25%',
                            value: 10,
                            color: ThemeColors.secondThemeAccent,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '5%',
                            value: 10,
                            color: ThemeColors.secondColor,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '5%',
                            value: 5,
                            color: ThemeColors.secondColor.withOpacity(0.6),
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '20%',
                            value: 5,
                            color: ThemeColors.secondThemeSecond,
                          ),
                        ]),
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
                                'Work(50%)',
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
                                    ? ThemeColors.darkBlue.withOpacity(0.7)
                                    : ThemeColors.secondThemeAccent,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Study(20%)',
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
                                    ? ThemeColors.darkBlue
                                    : ThemeColors.secondColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Exercise(55%)',
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
                                    ? ThemeColors.darkBlue
                                    : ThemeColors.secondColor.withOpacity(0.6),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Coding(15%)',
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
                                    ? ThemeColors.darkBlue
                                    : ThemeColors.secondThemeSecond,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Other(10%)',
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: (MediaQuery.sizeOf(context).width / 1.9),
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
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: ThemeColors.secondThemeMain),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: LineChart(
                          LineChartData(
                              borderData: FlBorderData(
                                  show: !true,
                                  border: Border.all(
                                    color: ThemeColors.secondThemeAccent,
                                    width: 2.0,
                                  )),
                              minX: 1,
                              maxX: 7,
                              minY: 0,
                              maxY: 9,
                              lineBarsData: [
                                LineChartBarData(
                                    color: ThemeColors.secondThemeMain,
                                    isCurved: true,
                                    belowBarData: BarAreaData(
                                        color: ThemeColors.secondColor
                                            .withOpacity(0.7),
                                        show: true),
                                    spots: [
                                      FlSpot(1, 0),
                                      FlSpot(2, 2),
                                      FlSpot(3, 3),
                                      FlSpot(4, 2),
                                      FlSpot(5, 4),
                                      FlSpot(6, 2),
                                      FlSpot(7, 1),
                                    ]),
                              ],
                              titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  rightTitles: AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  topTitles: AxisTitles(
                                    axisNameWidget: null,
                                  ),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (double dayNumber,
                                        TitleMeta titleMeta) {
                                      return Text(
                                        dayNumber.toStringAsFixed(0),
                                        style: TextStyle(
                                            color: ThemeColors.secondThemeMain),
                                      );
                                    },
                                  ))),
                              gridData: FlGridData(show: false)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
