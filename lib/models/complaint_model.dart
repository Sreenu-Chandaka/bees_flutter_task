class Complaint {
  String id;

  String date;
  String description;
  String type;
  String? fileName;

  Complaint({
    required this.id,
    required this.date,
    required this.description,
    required this.type,
    this.fileName,
  });
}
