import 'package:flutter/material.dart';
import 'package:scheduler/controller_bindings.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/utils/theme_colors.dart';
import 'package:scheduler/ui/utils/theme_controller.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scheduler',
      theme: _lightTheme(context),
      darkTheme: _darkTheme(context),
      themeMode: ThemeController.currentTheme,
      home: CommonBottomNavBar(),
      initialBinding: ControllerBindings(),
    );
  }

  ThemeData _lightTheme(BuildContext context) {
    return ThemeData(
      dialogTheme: DialogThemeData(
        backgroundColor: ThemeColors.lightColor,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ThemeColors.titleColor, fontWeight: FontWeight.w600),
        contentTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: ThemeColors.titleColor,
            ),
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
          ),
          labelSmall: TextStyle(fontSize: 10)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: ThemeColors.accentColor),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColors.accentColor,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColors.accentColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.titleColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          backgroundColor: ThemeColors.accentColor,
          foregroundColor: ThemeColors.lightColor,
          fixedSize: const Size.fromWidth(90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle:
            const TextStyle(fontSize: 14, color: ThemeColors.accentColor),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.lightColor)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.lightColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.lightColor)),
          constraints: BoxConstraints.tight(
            const Size.fromHeight(50),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        foregroundColor: ThemeColors.accentColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.titleColor,
          unselectedItemColor: Colors.white,
          elevation: 20,
          selectedItemColor: ThemeColors.lightColor),
    );
  }

  ThemeData _darkTheme(BuildContext context) {
    return ThemeData(
      dialogTheme: DialogThemeData(
        backgroundColor: ThemeColors.darkMain,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ThemeColors.darkAccent, fontWeight: FontWeight.w600),
        contentTextStyle: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: ThemeColors.darkAccent),
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ThemeColors.darkMain,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
          ),
          labelSmall: TextStyle(fontSize: 10)),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: ThemeColors.darkAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColors.darkAccent,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ThemeColors.darkAccent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.darkMain,
        foregroundColor: ThemeColors.darkAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          backgroundColor: ThemeColors.darkAccent,
          foregroundColor: ThemeColors.darkSecond,
          fixedSize: const Size.fromWidth(90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(fontSize: 14, color: ThemeColors.darkAccent),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
          constraints: BoxConstraints.tight(
            const Size.fromHeight(50),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: ThemeColors.darkBlue,
        foregroundColor: ThemeColors.darkSecond,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ThemeColors.darkMain,
          unselectedItemColor: ThemeColors.accentColor,
          elevation: 20,
          selectedItemColor: ThemeColors.darkAccent),
    );
  }
}
