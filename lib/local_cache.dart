import 'package:shared_preferences/shared_preferences.dart';

class LocalCache{
  static Future<void> saveDailyHourGoal(final double hour) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble('dailyFocusGoal', hour);
  }
  static Future<double?> getDailyHourGoal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble('dailyFocusGoal');
  }

  static Future<void> saveTheme({required final bool isDark}) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('theme', isDark);
  }
  static Future<bool?> fetchTheme() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('theme');
  }
}