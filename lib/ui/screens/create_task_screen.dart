import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import '../utils/theme_colors.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final DateTime _currentDate = DateTime.now();
  late int _fromTime;
  late int _toTime;
  late int _toTimeMin;

  @override
  void initState() {
    _fromTime = _currentDate.hour;
    _toTime = _currentDate.hour;
    _toTimeMin = _toTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberPicker(
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.black45),
                      selectedTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ThemeColors.titleColor),
                      minValue: _currentDate.hour,
                      maxValue: 24,
                      value: _fromTime,
                      onChanged: (i) {
                        _fromTime = i;
                        _toTimeMin = i;
                        _toTime = i;
                        setState(() {});
                      }),
                  Column(
                    children: [
                      Text(
                        'Time',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: ThemeColors.titleColor),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: ThemeColors.titleColor,
                        size: 30,
                      ),
                    ],
                  ),
                  NumberPicker(
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.black45),
                      selectedTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ThemeColors.titleColor),
                      minValue: _toTimeMin,
                      maxValue: 24,
                      value: _toTime,
                      onChanged: (i) {
                        _toTime = i;
                        setState(() {});
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: ThemeColors.titleColor),
                decoration: const InputDecoration(hintText: 'Title:'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 4,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: ThemeColors.titleColor),
                decoration: const InputDecoration(hintText: 'Description:'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(double.maxFinite)),
                child: const Text('Create Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
