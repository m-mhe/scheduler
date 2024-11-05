import 'package:flutter/material.dart';
import 'package:scheduler/ui/screens/home_screen.dart';
import 'package:scheduler/ui/screens/task_screen.dart';
import 'package:scheduler/ui/screens/previous_tasks_screen.dart';
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
            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_week),
                label: 'Old Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Calendar',
              )
            ]),
      );
    });
  }

  //----------------------------------Variables----------------------------------
  final List<Widget> screens = [
    const PreviousTasks(),
    const HomeScreen(),
    const TaskScreen(),
  ];
}
