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
      required this.year});

  final String title;
  final String subTitle;
  final int year;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor:
          Get.isDarkMode ? ThemeColors.darkMain : ThemeColors.lightColor,
      title: Text(
        'Have you completed this task?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor,
            ),
      ),
      content: Text(
        "If this task is completed then click 'Yes', Otherwise click 'No'. You can cancel this task by Deleting it.",
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
            await LocalDatabase.deleteFromActiveDB(title, year);
            Get.back();
          },
          child: const Icon(Icons.delete_outline),
        ),
        ElevatedButton(
          onPressed: () async {
            await LocalDatabase.saveInactiveTask(OldTaskDataModel(
                title: title, subTitle: subTitle, taskState: 'Completed'));
            await LocalDatabase.deleteFromActiveDB(title, year);
            Get.back();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
