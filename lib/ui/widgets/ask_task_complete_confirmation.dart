import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme_colors.dart';

class AskTaskCompleteConfirmation extends StatelessWidget {
  const AskTaskCompleteConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: ThemeColors.lightColor,
      title: Text(
        'Have you completed this task?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ThemeColors.titleColor,
            ),
      ),
      content: Text(
        "If this task is completed then click 'Yes', Otherwise click 'No'. You can cancel this task by Deleting it.",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: ThemeColors.titleColor,
            ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.delete_outline),
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
