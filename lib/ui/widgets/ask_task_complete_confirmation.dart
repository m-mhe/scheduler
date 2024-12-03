import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/old_task_data_model.dart';
import 'package:scheduler/local_database.dart';
import '../utils/theme_colors.dart';

class AskTaskCompleteConfirmation extends StatelessWidget {
  const AskTaskCompleteConfirmation(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iD});

  final String title;
  final String subTitle;
  final int iD;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor:
          Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
      title: Text(
        'Have you completed the task?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor,
            ),
      ),
      content: Text(
        "If this task is completed, click 'Yes.' Otherwise, click 'No' or cancel the task.",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor,
            ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () async {
            await LocalDatabase.saveInactiveTask(OldTaskDataModel(
                title: title, subTitle: subTitle, taskState: 'Canceled'));
            await LocalDatabase.deleteFromActiveDB(iD: iD);
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            await LocalDatabase.saveInactiveTask(OldTaskDataModel(
                title: title, subTitle: subTitle, taskState: 'Completed'));
            await LocalDatabase.deleteFromActiveDB(iD: iD);
            Get.back();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
