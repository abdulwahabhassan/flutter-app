class Note {
  const Note(
      { this.id,
      required this.title,
      required this.body,
       this.date});

  final int? id;
  final String title;
  final String body;
  final String? date;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "date": date
    };
  }

  @override
  String toString() {
    return "Note{id:$id title:$title body:$body date:$date}";
  }
}
