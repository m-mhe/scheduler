import 'package:shared_preferences/shared_preferences.dart';

class LocalCache{
  static Future<void> saveDailyHourGoal(final int hour) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('dailyFocusGoal', hour);
  }
  static Future<int?> getDailyHourGoal() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('dailyFocusGoal');
  }
}