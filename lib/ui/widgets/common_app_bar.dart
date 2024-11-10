import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/local_cache.dart';
import 'package:scheduler/ui/utils/theme_controller.dart';
import '../utils/theme_colors.dart';

AppBar commonAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'Scheduler',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Get.isDarkMode ? ThemeColors.darkAccent : Colors.white),
    ),
    actions: [
      IconButton(
          onPressed: () {
            final bool isDarkMode = Get.isDarkMode;
            Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
            LocalCache.saveTheme(isDark: !isDarkMode);
          },
          icon: Get.isDarkMode
              ? const Icon(Icons.dark_mode_rounded)
              : const Icon(Icons.dark_mode_outlined))
    ],
  );
}
