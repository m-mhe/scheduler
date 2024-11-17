import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/focus_session_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/screens/focus_session_statics_screen.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
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
  @override
  void initState() {
    _endTime = widget.endTime;
    _breakEndTime = widget.breakEndTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
      appBar: commonAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _focusSessionDetails(context),
                  _timeView(context),
                  _taskLevel(),
                  _focusSessionController(context)
                ],
              ),
            ),
          ),
          _totalTime(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FocusSessionStaticsScreen());
        },
        child: const Icon(
          Icons.insert_chart,
          size: 34,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  //----------------------------------------------Variables----------------------------------------------
  Timer? _timer;
  bool _isTimerOn = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _focusSessions = 0;
  double _endTime = 24;
  double _breakEndTime = 4;
  double _completedTime = 0;
  int _second = 60;
  bool _isBreak = false;
  String _currentTaskType = 'Study';
  final List<String> _taskTypes = [
    'Study',
    'Work',
    'Exercise',
    'Coding',
    'Other',
  ];

  //----------------------------------------------Functions----------------------------------------------
  void _timeCountdown() {
    bool skip = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (_isBreak) {
        if (_second != 1) {
          _second--;
        } else {
          if (_completedTime == _breakEndTime) {
            _completedTime = 0;
            skip = true;
            timer.cancel();
            _isTimerOn = false;
            await _audioPlayer.release();
            await _audioPlayer.play(
              AssetSource('audio/ringtone_on_complete.mp3'),
            );
            await _audioPlayer.setReleaseMode(ReleaseMode.stop);
            await showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Get.isDarkMode
                      ? ThemeColors.darkMain
                      : ThemeColors.lightColor,
                  title: Text(
                    'Break over',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                  ),
                  content: Text(
                    'Time to refocus and continue your progress! Let\'s dive back into the next session.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await _audioPlayer.release();
                        _isBreak = false;
                        _timeCountdown();
                        _isTimerOn = true;
                        Get.back();
                      },
                      child: const Text('Yes'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _audioPlayer.release();
                        _isBreak = true;
                        _timeCountdown();
                        _isTimerOn = true;
                        Get.back();
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              }),
            );
          }
          if (skip) {
            skip = false;
          } else {
            _completedTime++;
          }
          _second = 60;
        }
      } else {
        if (_second != 1) {
          _second--;
        } else {
          if (_completedTime == _endTime) {
            _completedTime = 0;
            _focusSessions++;
            skip = true;
            timer.cancel();
            _isTimerOn = false;
            await _audioPlayer.release();
            await _audioPlayer.play(
              AssetSource('audio/ringtone_on_complete.mp3'),
            );
            await _audioPlayer.setReleaseMode(ReleaseMode.stop);
            await LocalDatabase.saveFocusSessions(FocusSessionDataModel(
                minutes: ((widget.endTime) + 1).toInt(),
                dateTime: DateTime.now(),
                taskType: _currentTaskType));
            await showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Get.isDarkMode
                      ? ThemeColors.darkMain
                      : ThemeColors.lightColor,
                  title: Text(
                    'Take a short break',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                  ),
                  content: Text(
                    'Great job! You have completed a ${widget.endTime + 1} minutes focus session, do you wanna take a short break to recharge?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await _audioPlayer.release();
                        _isBreak = true;
                        _timeCountdown();
                        _isTimerOn = true;
                        Get.back();
                      },
                      child: const Text('Yes'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _audioPlayer.release();
                        _isBreak = false;
                        _timeCountdown();
                        _isTimerOn = true;
                        Get.back();
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              }),
            );
          }
          if (skip) {
            skip = false;
          } else {
            _completedTime++;
          }
          _second = 60;
        }
      }
      setState(() {});
    });
  }

  //----------------------------------------------Widgets----------------------------------------------
  Container _totalTime(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color:
              Get.isDarkMode ? ThemeColors.darkSecond : ThemeColors.accentColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Center(
          child: Text(
        'Total focus time: ${(_focusSessions * (_endTime + 1)).toStringAsFixed(0)} min',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Get.isDarkMode
                ? ThemeColors.darkAccent
                : ThemeColors.lightColor),
      )),
    );
  }

  Row _focusSessionController(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Get.isDarkMode
                      ? ThemeColors.darkMain
                      : ThemeColors.lightColor,
                  title: Text(
                    'Tune Your Focus',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                  ),
                  content: SizedBox(
                    height: 150,
                    width: double.maxFinite,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.horizontal,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              Get.back();
                            },
                            icon: Icon(
                              Icons.music_off_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/clock.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.watch_later_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/owls.mp3'),
                                volume: 0.9,
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.nights_stay_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/fire.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.local_fire_department_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/piano_one.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.piano_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/water.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.water_drop_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/memory.mp3'),
                                volume: 0.9,
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.donut_small,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/stream_one.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.water_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/cheel.mp3'),
                                volume: 0.9,
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.lens_blur_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/stream_two.mp3'),
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.water_sharp,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/time.mp3'),
                                volume: 0.9,
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.av_timer_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/rain.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.water_drop_outlined,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/eddy.mp3'),
                                volume: 0.9,
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.earbuds,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer
                                  .play(AssetSource('audio/thunderstorm.mp3'));
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.thunderstorm_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/lofi_rain.mp3'),
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.music_note_rounded,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              await _audioPlayer.release();
                              await _audioPlayer.play(
                                AssetSource('audio/forest_rain.mp3'),
                              );
                              await _audioPlayer
                                  .setReleaseMode(ReleaseMode.loop);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.forest_sharp,
                              color: Get.isDarkMode
                                  ? ThemeColors.darkAccent
                                  : ThemeColors.accentColor,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
          icon: const Icon(Icons.my_library_music_rounded),
          color:
              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.accentColor,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.accentColor),
          onPressed: () {
            setState(() {});
            if (_isTimerOn) {
              _timer!.cancel();
              _isTimerOn = false;
            } else {
              _timeCountdown();
              _isTimerOn = true;
            }
          },
          icon: _isTimerOn
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow_rounded),
          color: Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () async {
            _completedTime = 0;
            _second = 60;
            _isBreak = false;
            _timer?.cancel();
            _isTimerOn = false;
            await _audioPlayer.release();
            setState(() {});
          },
          icon: const Icon(Icons.stop_circle_rounded),
          color:
              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.accentColor,
        ),
      ],
    );
  }

  Padding _taskLevel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        _isBreak ? 'Break' : _currentTaskType,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color:
              Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.accentColor,
        ),
      ),
    );
  }

  Padding _timeView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 2.3,
            width: MediaQuery.of(context).size.width / 3.3,
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? ThemeColors.darkSecond
                    : ThemeColors.accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              ((_isBreak ? _breakEndTime : _endTime) - _completedTime.toInt())
                  .toStringAsFixed(0)
                  .padLeft(2, '0'),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Get.isDarkMode
                    ? ThemeColors.darkAccent
                    : ThemeColors.lightColor,
              ),
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Get.isDarkMode
                      ? _second.isEven
                          ? ThemeColors.darkAccent
                          : ThemeColors.darkSecond
                      : _second.isEven
                          ? ThemeColors.accentColor
                          : ThemeColors.accentColor.withOpacity(0.5),
                  radius: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: CircleAvatar(
                  backgroundColor: Get.isDarkMode
                      ? _second.isEven
                          ? ThemeColors.darkAccent
                          : ThemeColors.darkSecond
                      : _second.isEven
                          ? ThemeColors.accentColor
                          : ThemeColors.accentColor.withOpacity(0.5),
                  radius: 5,
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.width / 2.3,
            width: MediaQuery.of(context).size.width / 3.3,
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? ThemeColors.darkSecond
                    : ThemeColors.accentColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                _second.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.lightColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _focusSessionDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15,
          bottom: MediaQuery.of(context).size.height / 6,
          left: 10,
          right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Focus: ${(_endTime + 1).toStringAsFixed(0)} min',
            style: TextStyle(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          DropdownMenu(
              onSelected: (v) {
                _currentTaskType = _taskTypes[v!];
                setState(() {});
              },
              initialSelection: 0,
              label: Text(
                'Task type',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Get.isDarkMode
                        ? ThemeColors.darkAccent
                        : ThemeColors.accentColor),
              ),
              width: 125,
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 0, label: _taskTypes[0]),
                DropdownMenuEntry(value: 1, label: _taskTypes[1]),
                DropdownMenuEntry(value: 2, label: _taskTypes[2]),
                DropdownMenuEntry(value: 3, label: _taskTypes[3]),
                DropdownMenuEntry(value: 4, label: _taskTypes[4]),
              ]),
          Text(
            'Break: ${(_breakEndTime + 1).toStringAsFixed(0)} min',
            style: TextStyle(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
