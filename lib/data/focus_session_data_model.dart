class FocusSessionDataModel {
  FocusSessionDataModel({
    required this.minutes,
    required this.dateTime,
    required this.taskType,
  });

  final int minutes;
  final DateTime dateTime;
  final String taskType;

  Map<String, dynamic> toMap() {
    return {
      'minutes': minutes,
      'dateTime': dateTime.toString(),
      'taskType': taskType,
    };
  }
}
