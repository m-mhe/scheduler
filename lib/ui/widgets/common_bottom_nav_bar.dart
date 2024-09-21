import 'package:flutter/material.dart';
import 'package:scheduler/ui/screens/home_screen.dart';
import 'package:scheduler/ui/screens/task_screen.dart';
import 'package:scheduler/ui/screens/week_planer_screen.dart';
import 'package:scheduler/ui/utils/nav_bar_controller.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:get/get.dart';

class CommonBottomNavBar extends StatelessWidget {
  CommonBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (controller) {
      return Scaffold(
        appBar: commonAppBar(context),
        body: screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: Get.find<NavBarController>().currentIndex,
            onTap: (index) {
              Get.find<NavBarController>().setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_week),
                label: 'Week Scheduler',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined),
                label: 'Tasks',
              )
            ]),
      );
    });
  }

  //----------------------------------Variables----------------------------------
  final List<Widget> screens = [
    const WeekPlanerScreen(),
    const HomeScreen(),
    const TaskScreen(),
  ];
}
