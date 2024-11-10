import 'package:flutter/material.dart';

class ThemeController{
  static ThemeMode currentTheme = ThemeMode.system;
  static void changeTheme({required final bool? isDark}){
    if(isDark!=null){
      currentTheme= isDark?ThemeMode.dark:ThemeMode.light;
    }
  }
}