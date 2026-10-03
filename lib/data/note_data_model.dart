class NoteDataModel {
  NoteDataModel({
    this.ID,
    required this.title,
    required this.body,
    required this.updation_time,
  });

  final int? ID;
  final String title;
  final String body;
  final String updation_time;

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body, 'updation_time': updation_time};
  }
}
