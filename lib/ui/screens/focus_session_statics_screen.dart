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
      appBar: commonAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width/1.4,
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
                child: Center(
                  child: SleekCircularSlider(
                    initialValue: 0.556,
                    min: 0,
                    max: 3,
                    appearance: CircularSliderAppearance(
                      spinnerMode: false,
                      size: MediaQuery.sizeOf(context).width/1.6,
                      angleRange: 360,
                      startAngle: 270,
                      customWidths: CustomSliderWidths(
                        trackWidth: 15,
                        progressBarWidth: 15,
                        handlerSize: 0,
                      ),
                      customColors: CustomSliderColors(
                        trackColor: ThemeColors.darkAccent,
                        progressBarColor: ThemeColors.accentColor,
                        shadowColor: ThemeColors.accentColor,
                        hideShadow: true,
                      ),
                      infoProperties: InfoProperties(
                        topLabelText: 'Daily Goal',
                        topLabelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: ThemeColors.accentColor),
                        modifier: (v){
                          return '${v.toStringAsFixed(1)} h';
                        },
                        mainLabelStyle: const TextStyle(
                          color: ThemeColors.accentColor,
                          fontSize: 28
                        ),
                        bottomLabelText: '2.5 hours left',
                        bottomLabelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: ThemeColors.accentColor),
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width/1.65,
                    height: MediaQuery.sizeOf(context).width/1.65,
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
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width-((MediaQuery.sizeOf(context).width/1.65)+30),
                    height: MediaQuery.sizeOf(context).width/1.65,
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
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: (MediaQuery.sizeOf(context).width/2),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
