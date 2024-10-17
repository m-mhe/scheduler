import 'package:flutter/material.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({super.key});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
    );
  }
}
