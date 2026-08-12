class NoteDataModel {
  NoteDataModel(
      {this.ID,
        required this.title,
        required this.body,
        required this.creation_time,});

  final int? ID;
  final String title;
  final String body;
  String creation_time;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'creation_time': creation_time,
    };
  }
}
