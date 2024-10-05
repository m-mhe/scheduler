import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme_colors.dart';

AppBar commonAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'Scheduler',
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Get.isDarkMode?ThemeColors.darkAccent:Colors.white),
    ),
    actions: [
      IconButton(
          onPressed: () {
            Get.changeThemeMode(
              Get.isDarkMode?ThemeMode.light:ThemeMode.dark
            );
          }, icon: Get.isDarkMode?const Icon(Icons.dark_mode_rounded):const Icon(Icons.wb_twilight_rounded))
    ],
  );
}
