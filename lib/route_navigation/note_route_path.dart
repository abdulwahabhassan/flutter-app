class NoteRoutePath {
  final int? id;

  NoteRoutePath.notes() : id = null;

  NoteRoutePath.details(this.id);

  bool get isNotesPage => id == null;

  bool get isDetailsPage => id != null;
}
