class Note {
  double latitude;
  double longitude;
  String title;
  String description;
  DateTime dateTime;
  int? id;
  Note({
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.description,
    required this.dateTime,
    this.id,
  });
}
