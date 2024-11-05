import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initializer() async {
    await Future.delayed(const Duration(milliseconds: 250));
    Get.offAll(()=>CommonBottomNavBar());
  }

  @override
  void initState() {
    _initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/img/parent_logo.png',
          width: MediaQuery.sizeOf(context).width / 1.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
