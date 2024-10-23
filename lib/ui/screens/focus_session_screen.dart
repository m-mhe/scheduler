import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final AudioPlayer _audioPlayer = AudioPlayer();
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
                  padding: EdgeInsets.only(
                      top: 15,
                      bottom: MediaQuery.of(context).size.height / 15,
                      left: 10,
                      right: 10),
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
                    padding: const EdgeInsets.only(bottom: 10),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Get.isDarkMode
                                          ? ThemeColors.darkAccent
                                          : ThemeColors.titleColor,
                                    ),
                              ),
                              content: SizedBox(
                                height: 100,
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
                                        icon: const Icon(
                                          Icons.music_off_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                              AssetSource('audio/clock.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.watch_later_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/owls.mp3'),
                                            volume: 0.7,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.nights_stay_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                              AssetSource('audio/fire.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.local_fire_department_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(AssetSource(
                                              'audio/piano_one.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.piano_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                              AssetSource('audio/water.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.water_drop_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/memory.mp3'),
                                            volume: 0.5,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.donut_small,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(AssetSource(
                                              'audio/stream_one.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.water_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/cheel.mp3'),
                                            volume: 0.5,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.lens_blur_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/stream_two.mp3'),
                                            volume: 0.5,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.water_sharp,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/time.mp3'),
                                            volume: 0.5,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.av_timer_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                              AssetSource('audio/rain.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.water_drop_outlined,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(
                                            AssetSource('audio/eddy.mp3'),
                                            volume: 0.5,
                                          );
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.earbuds,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          await _audioPlayer.release();
                                          await _audioPlayer.play(AssetSource(
                                              'audio/thunderstorm.mp3'));
                                          await _audioPlayer.setReleaseMode(ReleaseMode.loop);
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.thunderstorm_rounded,
                                          color: ThemeColors.accentColor,
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.music_off_rounded)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.music_off_rounded)),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
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
                          await Future.delayed(
                              const Duration(milliseconds: 997));
                          if (_isBreak) {
                            if (_second != 1) {
                              _second--;
                              _completedTime =
                                  _completedTime + 0.0166666666666667;
                            } else {
                              if (_completedTime >= _breakEndTime) {
                                _completedTime = 0;
                                skip = true;
                                await _audioPlayer.release();
                                await _audioPlayer.play(
                                  AssetSource('audio/ringtone_on_complete.mp3'),
                                );
                                await _audioPlayer.setReleaseMode(ReleaseMode.release);
                                await showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      backgroundColor: Get.isDarkMode
                                          ? ThemeColors.darkMain
                                          : ThemeColors.lightColor,
                                      title: Text(
                                        'Break over',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Get.isDarkMode
                                                  ? ThemeColors.darkAccent
                                                  : ThemeColors.titleColor,
                                            ),
                                      ),
                                      content: Text(
                                        'Time to refocus and continue your progress! Let\'s dive back into the next session.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
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
                                            Get.back();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await _audioPlayer.release();
                                            _isBreak = true;
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
                                skip = true;
                                await _audioPlayer.release();
                                await _audioPlayer.play(
                                  AssetSource('audio/ringtone_on_complete.mp3'),
                                );
                                await _audioPlayer.setReleaseMode(ReleaseMode.release);
                                await showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      backgroundColor: Get.isDarkMode
                                          ? ThemeColors.darkMain
                                          : ThemeColors.lightColor,
                                      title: Text(
                                        'Take a short break',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Get.isDarkMode
                                                  ? ThemeColors.darkAccent
                                                  : ThemeColors.titleColor,
                                            ),
                                      ),
                                      content: Text(
                                        'Great job! You have completed a ${widget.endTime + 1} minutes focus, do you wanna take a short break to recharge?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
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
                                            Get.back();
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await _audioPlayer.release();
                                            _isBreak = false;
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
