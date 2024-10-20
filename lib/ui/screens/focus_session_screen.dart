import 'package:flutter/material.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../utils/theme_colors.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen(
      {super.key, required this.endTime, required this.breakEndTime});

  final double endTime;
  final double breakEndTime;

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  int _focusSessions = 0;
  bool _focusMode = false;
  final double _startTime = 0;
  double _endTime = 24;
  double _breakEndTime = 4;
  double _completedTime = 0;
  int _second = 60;
  bool _isBreak = false;
  String _currentTaskType = 'Work';
  final List<String> _taskTypes = [
    'Work',
    'Study',
    'Exercise',
    'Coding',
    'Other',
  ];

  @override
  void initState() {
    _endTime = widget.endTime;
    _breakEndTime = widget.breakEndTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.lightColor,
      appBar: commonAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Focus: ${(_endTime + 1).toStringAsFixed(0)} min',
                        style: const TextStyle(
                          color: ThemeColors.accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      DropdownMenu(
                          onSelected: (v) {
                            _currentTaskType = _taskTypes[v!];
                            setState(() {});
                          },
                          initialSelection: 0,
                          menuHeight: 150,
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
                            DropdownMenuEntry(value: 4, label: _taskTypes[4]),
                          ]),
                      Text(
                        'Break: ${(_breakEndTime + 1).toStringAsFixed(0)} min',
                        style: const TextStyle(
                          color: ThemeColors.accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: SleekCircularSlider(
                      initialValue: _completedTime,
                      min: _startTime,
                      max: _isBreak ? (_breakEndTime + 1) : (_endTime + 1),
                      appearance: CircularSliderAppearance(
                          spinnerMode: false,
                          angleRange: 360,
                          startAngle: 270,
                          size: MediaQuery.sizeOf(context).width / 1.4,
                          customWidths: CustomSliderWidths(
                            trackWidth: 7,
                            progressBarWidth: 7,
                            shadowWidth: 12,
                            handlerSize: 0,
                          ),
                          customColors: CustomSliderColors(
                            trackColor: ThemeColors.darkAccent,
                            progressBarColor: ThemeColors.accentColor,
                            shadowColor: ThemeColors.accentColor,
                            hideShadow: false,
                          ),
                          infoProperties: InfoProperties(
                              topLabelText:
                                  _isBreak ? 'Break' : _currentTaskType,
                              topLabelStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: ThemeColors.accentColor),
                              modifier: (v) {
                                return '${(_endTime - v.toInt()).toStringAsFixed(0).padLeft(2, '0')}:${_second.toString().padLeft(2, '0')}';
                              },
                              bottomLabelText: _focusMode ? null : 'Paused',
                              mainLabelStyle: const TextStyle(
                                  fontSize: 46, color: ThemeColors.accentColor),
                              bottomLabelStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: ThemeColors.accentColor))),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.my_library_music_rounded),
                      color: ThemeColors.accentColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: ThemeColors.accentColor),
                      onPressed: () async {
                        _focusMode = !_focusMode;
                        setState(() {});
                        bool skip = false;
                        while (_focusMode) {
                          await Future.delayed(const Duration(seconds: 1));
                          if (_isBreak) {
                            if (_second != 1) {
                              _second--;
                              _completedTime =
                                  _completedTime + 0.0166666666666667;
                            } else {
                              if (_completedTime >= _breakEndTime) {
                                _completedTime = 0;
                                _isBreak = false;
                                skip = true;
                              }
                              if (skip) {
                                skip = false;
                              } else {
                                _completedTime =
                                    _completedTime + 0.0166666666666667;
                              }
                              _second = 60;
                            }
                          } else {
                            if (_second != 1) {
                              _second--;
                              _completedTime =
                                  _completedTime + 0.0166666666666667;
                            } else {
                              if (_completedTime >= _endTime) {
                                _completedTime = 0;
                                _focusSessions++;
                                _isBreak = true;
                                skip = true;
                              }
                              if (skip) {
                                skip = false;
                              } else {
                                _completedTime =
                                    _completedTime + 0.0166666666666667;
                              }
                              _second = 60;
                            }
                          }
                          setState(() {});
                        }
                      },
                      icon: _focusMode
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow_rounded),
                      color: ThemeColors.lightColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.stop_circle_rounded),
                      color: ThemeColors.accentColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: ThemeColors.accentColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Center(
                child: Text(
              'Total session time: ${(_focusSessions * (_endTime + 1)).toStringAsFixed(0)} min',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: ThemeColors.lightColor),
            )),
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
