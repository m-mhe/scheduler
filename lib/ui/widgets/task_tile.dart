import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.taskTitle,
    required this.subTitle,
    required this.taskStatus,
    required this.onTap,
  });

  final String taskTitle;
  final String subTitle;
  final String taskStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.lightColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: ListTile(
        title: Text(
          taskTitle.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: taskStatus == 'Completed'||taskStatus == 'Due'
                    ? ThemeColors.titleColor
                    : Colors.red,
              ),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: taskStatus == 'Completed'||taskStatus == 'Due'
                    ? ThemeColors.titleColor
                    : Colors.red,
              ),
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: taskStatus == 'Completed'||taskStatus == 'Due'
                  ? ThemeColors.accentColor
                  : Colors.red),
          child: Text(taskStatus),
        ),
      ),
    );
  }
}
