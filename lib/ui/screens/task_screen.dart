import 'package:flutter/material.dart';

import '../utils/theme_colors.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                  color: ThemeColors.lightColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: ListTile(
                  title: Text(
                    'Task Title',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: ThemeColors.titleColor,
                        ),
                  ),
                  subtitle: Text(
                    '${_currentDate.hour}:${_currentDate.minute}:${_currentDate.second}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: ThemeColors.titleColor,
                        ),
                  ),
                  trailing:
                      ElevatedButton(onPressed: () {}, child: Text('Due')),
                ),
              );
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 20,
              );
            },
            itemCount: 20),
      ),
    );
  }
}
