import 'package:flutter/material.dart';

SnackBar bottomPopupMessage({required String text, required Color color}) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(
      text,
      textAlign: TextAlign.center,
    ),
    backgroundColor: color,
  );
}
