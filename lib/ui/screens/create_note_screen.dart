import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../utils/theme_colors.dart';
import '../widgets/common_app_bar.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: commonAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height/30),
              child: TextField(
                textInputAction: TextInputAction.next,
                maxLength: 20,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color:
                    Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.titleColor),
                decoration: const InputDecoration(hintText: 'Title:',),
              ),
            ),
            TextField(
              maxLines: 10,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color:
                  Get.isDarkMode ? ThemeColors.darkAccent : ThemeColors.titleColor),
              decoration: const InputDecoration(hintText: 'Description (optional):'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(
                        double.maxFinite), //Size(double width, double height)
                  ), child: Text("Take Note")),
            )
          ],
        ),
      ),
    );
  }
}
