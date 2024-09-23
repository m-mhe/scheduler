import 'package:flutter/material.dart';
import 'package:scheduler/controller_bindings.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/utils/theme_colors.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scheduler',
      theme: ThemeData(
        textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          labelLarge: TextStyle(fontSize: 16),
          labelSmall: TextStyle(fontSize: 10)
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: ThemeColors.accentColor),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ThemeColors.accentColor,),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ThemeColors.accentColor,),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.titleColor,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
            backgroundColor: ThemeColors.accentColor,
            foregroundColor: ThemeColors.lightColor,
            fixedSize: const Size.fromWidth(90),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            )
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.lightColor,
          foregroundColor: ThemeColors.accentColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            unselectedItemColor: Colors.black87,
            elevation: 20,
            selectedItemColor: ThemeColors.accentColor),
      ),
      home: CommonBottomNavBar(),
      initialBinding: ControllerBindings(),
    );
  }
}
