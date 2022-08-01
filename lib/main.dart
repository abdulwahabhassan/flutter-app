
import 'package:flutter/material.dart';

import 'note_details_page.dart';
import 'notes_page.dart';
import 'model.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<StatefulWidget> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  Note? _selectedNote = null;
  List<Note> notes = Note.notes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey("homePage"),
              child: NotesPage(
                items: notes,
                onSelectNote: _setSelectedNote,
              )),
          if (_selectedNote != null )
            MaterialPage(
              key: ValueKey(_selectedNote?.id),
              child: DetailsPage(note: _selectedNote!),
            )
          ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          _unsetSelectedNote();
          return true;
        },
      ),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }

  void _setSelectedNote(Note note) {
    setState(() {
      _selectedNote = note;
    });
  }

  void _unsetSelectedNote() {
    setState(() {
      _selectedNote = null;
    });
  }
}

void main() {
  runApp(const NotesApp());
}
