class EntityTwo {
  EntityTwo(
      {required this.title,
        required this.subTitle,
        required this.taskState,});

  final String title;
  final String subTitle;
  final String taskState;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subTitle,
      'taskState': taskState,
    };
  }
}
