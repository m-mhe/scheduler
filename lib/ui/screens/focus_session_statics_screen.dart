import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
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
      backgroundColor: Color(0XFFE9EED9),
      appBar: AppBar(
        title: Text(
          'Statics',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        backgroundColor: Color(0XFF5F6F52),
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
                width: MediaQuery.sizeOf(context).width,
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
                        animDurationMultiplier: 5,
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
                          progressBarColor: Color(0XFF5F6F52),
                          hideShadow: true,
                        ),
                        infoProperties: InfoProperties(
                          topLabelText: 'Daily Goal',
                          topLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Color(0XFF5F6F52),
                                  ),
                          modifier: (v) {
                            return '${v.toStringAsFixed(1)} h';
                          },
                          mainLabelStyle: const TextStyle(
                            color: Color(0XFF5F6F52),
                            fontSize: 28,
                          ),
                          bottomLabelText: '1 hours left',
                          bottomLabelStyle:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Color(0XFF5F6F52),
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
                            value: 50,
                            color: Color(0XFF5F6F52),
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '25%',
                            value: 25,
                            color: Color(0XFFA9B388),
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            title: '5%',
                            value: 5,
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
                            value: 20,
                            color: Color(0XFFE9EED9),
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
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
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
