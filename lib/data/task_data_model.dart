class TaskDataModel {
  TaskDataModel(
      {this.iD,
      required this.title,
      required this.subTitle,
      required this.taskState,
      required this.fromTime,
      required this.toTime,
      required this.date,
      required this.month,
      required this.year});

  final int? iD;
  final String title;
  final String subTitle;
  String taskState;
  final int fromTime;
  final int toTime;
  int date;
  int month;
  int year;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subTitle,
      'taskState': taskState,
      'fromTime': fromTime,
      'toTime': toTime,
      'date': date,
      'month': month,
      'year': year,
    };
  }
}
