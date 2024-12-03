import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/task_data_model.dart';
import 'package:scheduler/ui/screens/task_edit_screen.dart';
import '../utils/theme_colors.dart';

class AskForEditConfirmation extends StatelessWidget {
  const AskForEditConfirmation({super.key, required this.taskDataModel});

  final TaskDataModel taskDataModel;

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
        taskDataModel.title.toUpperCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkAccent
                  : ThemeColors.titleColor,
            ),
      ),
      content: Text(
        "Do you want to edit or postpone this task?",
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
          child: const Text('Postpone'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.off(TaskEditScreen(taskDataModel: taskDataModel));
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }
}
