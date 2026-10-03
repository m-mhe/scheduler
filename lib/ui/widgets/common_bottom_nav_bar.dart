import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/ui/screens/Note.dart';
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
          type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex,
            onTap: (index) {
              controller.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections),
                activeIcon: Icon(CupertinoIcons.collections_solid),
                label: 'Old Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined),
              activeIcon: Icon(Icons.note_add_rounded),
              label: "Note"),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.calendar_today),
                activeIcon: Icon(CupertinoIcons.calendar_today),
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
    const Note(),
    const TaskScreen(),
  ];
}
