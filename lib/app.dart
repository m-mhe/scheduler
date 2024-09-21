import 'package:flutter/material.dart';
import 'package:scheduler/controller_bindings.dart';
import 'package:scheduler/ui/screens/home_screen.dart';
import'package:get/get.dart';
import 'package:scheduler/ui/utils/nav_bar_controller.dart';
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
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF7F6545),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 20,
          selectedItemColor: Color(0XFF7F6545)
        )
      ),
      home: CommonBottomNavBar(),
      initialBinding: ControllerBindings(),
    );
  }
}
