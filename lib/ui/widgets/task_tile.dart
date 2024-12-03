import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';
import 'package:get/get.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.taskTitle,
    required this.subTitle,
    required this.taskStatus,
    required this.onTapForComplete,
    required this.onTapForEdit,
  });

  final String taskTitle;
  final String subTitle;
  final String taskStatus;
  final VoidCallback onTapForComplete;
  final VoidCallback onTapForEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ThemeColors.darkSecond : ThemeColors.lightColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: ListTile(
        title: InkWell(
          onTap: onTapForEdit,
          child: Text(
            taskTitle.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: taskStatus == 'Completed' || taskStatus == 'Due'
                      ? Get.isDarkMode
                          ? ThemeColors.darkAccent
                          : ThemeColors.titleColor
                      : Colors.red,
                ),
          ),
        ),
        subtitle: InkWell(
          onTap: onTapForEdit,
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: taskStatus == 'Completed' || taskStatus == 'Due'
                      ? Get.isDarkMode
                          ? ThemeColors.darkAccent
                          : ThemeColors.accentColor
                      : Colors.red,
                ),
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onTapForComplete,
          style: ElevatedButton.styleFrom(
              backgroundColor: taskStatus == 'Completed' || taskStatus == 'Due'
                  ? Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.accentColor
                  : Colors.red),
          child: Text(taskStatus),
        ),
      ),
    );
  }
}
