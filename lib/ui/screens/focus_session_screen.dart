import 'package:flutter/material.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../utils/theme_colors.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({super.key});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  double _startTime = 0;
  double _endTime = 25;
  double _completedTime = 5;
  int _second = 60;
  List<String> _taskTypes = [
    'Work',
    'Study',
    'Exercise',
    'Other',
  ];
  List<int> _focusTimes = [
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
  List<int> _breakTimes = [
    5,
    10,
    15,
    20,
    25,
    30,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.lightColor,
      appBar: commonAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                  menuHeight:150,
                    label: Text(
                      'Task type',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ThemeColors.titleColor),
                    ),
                    width: 102,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 0, label: _taskTypes[0]),
                      DropdownMenuEntry(value: 1, label: _taskTypes[1]),
                      DropdownMenuEntry(value: 2, label: _taskTypes[2]),
                      DropdownMenuEntry(value: 3, label: _taskTypes[3]),
                    ]),
                DropdownMenu(
                    menuHeight:150,
                    label: Text('Focus time', style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ThemeColors.titleColor),),
                    width: 102,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 0, label: '${_focusTimes[0]} minute'),
                      DropdownMenuEntry(value: 1, label: '${_focusTimes[1]} minute'),
                      DropdownMenuEntry(value: 2, label: '${_focusTimes[2]} minute'),
                      DropdownMenuEntry(value: 3, label: '${_focusTimes[3]} minute'),
                      DropdownMenuEntry(value: 4, label: '${_focusTimes[4]} minute'),
                      DropdownMenuEntry(value: 5, label: '${_focusTimes[5]} minute'),
                      DropdownMenuEntry(value: 6, label: '${_focusTimes[6]} minute'),
                      DropdownMenuEntry(value: 7, label: '${_focusTimes[7]} minute'),
                      DropdownMenuEntry(value: 8, label: '${_focusTimes[8]} minute'),
                      DropdownMenuEntry(value: 9, label: '${_focusTimes[9]} minute'),
                      DropdownMenuEntry(value: 10, label: '${_focusTimes[10]} minute'),
                      DropdownMenuEntry(value: 11, label: '${_focusTimes[11]} minute'),
                      DropdownMenuEntry(value: 12, label: '${_focusTimes[12]} minute'),
                      DropdownMenuEntry(value: 13, label: '${_focusTimes[13]} minute'),
                      DropdownMenuEntry(value: 14, label: '${_focusTimes[14]} minute'),
                      DropdownMenuEntry(value: 15, label: '${_focusTimes[15]} minute'),
                      DropdownMenuEntry(value: 16, label: '${_focusTimes[16]} minute'),
                      DropdownMenuEntry(value: 17, label: '${_focusTimes[17]} minute'),
                      DropdownMenuEntry(value: 18, label: '${_focusTimes[18]} minute'),
                    ]),
                DropdownMenu(
                    menuHeight:150,
                    label: Text('Break time', style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ThemeColors.titleColor),),
                    width: 102,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 0, label: '${_breakTimes[0]} minute'),
                      DropdownMenuEntry(value: 1, label: '${_breakTimes[1]} minute'),
                      DropdownMenuEntry(value: 2, label: '${_breakTimes[2]} minute'),
                      DropdownMenuEntry(value: 3, label: '${_breakTimes[3]} minute'),
                      DropdownMenuEntry(value: 4, label: '${_breakTimes[4]} minute'),
                      DropdownMenuEntry(value: 5, label: '${_breakTimes[5]} minute'),
                    ]),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SleekCircularSlider(
                initialValue: _completedTime,
                min: _startTime,
                max: _endTime,
                appearance: CircularSliderAppearance(
                    spinnerMode: false,
                    angleRange: 360,
                    startAngle: 270,
                    size: MediaQuery.sizeOf(context).width / 1.5,
                    customWidths: CustomSliderWidths(
                      trackWidth: 10,
                      progressBarWidth: 10,
                      shadowWidth: 17,
                      handlerSize: 0,
                    ),
                    customColors: CustomSliderColors(
                      trackColor: ThemeColors.darkAccent,
                      progressBarColor: ThemeColors.accentColor,
                      shadowColor: ThemeColors.accentColor,
                      hideShadow: false,
                    ),
                    infoProperties: InfoProperties(
                        modifier: (v) {
                          return '${v.toStringAsFixed(0)}:$_second';
                        },
                        bottomLabelText: 'Paused',
                        mainLabelStyle: TextStyle(
                            fontSize: 46, color: ThemeColors.accentColor),
                        bottomLabelStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: ThemeColors.accentColor))),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.analytics_rounded,
          size: 34,
        ),
      ),
    );
  }
}
