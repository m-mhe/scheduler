import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/entity_two.dart';
import 'package:scheduler/database_setup.dart';
import '../utils/theme_colors.dart';

class AskTaskCompleteConfirmation extends StatelessWidget {
  const AskTaskCompleteConfirmation(
      {super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

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
          onPressed: () async {
            await DatabaseSetup.saveInactiveTask(EntityTwo(
                title: title, subTitle: subTitle, taskState: 'Completed'));
            await DatabaseSetup.deleteFromActiveDB(title);
            Get.back();
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () async {
            await DatabaseSetup.saveInactiveTask(EntityTwo(
                title: title, subTitle: subTitle, taskState: 'Canceled'));
            await DatabaseSetup.deleteFromActiveDB(title);
            Get.back();
          },
          child: const Icon(Icons.delete_outline),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
