import 'package:flutter/material.dart';
import 'package:flutter_app/note_details_screen.dart';
import 'model/note.dart';
import 'notes_screen.dart';

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  Note? _selectedNote;
  List<Note> notes = Note.notes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey("homePage"),
              child: NotesScreen(
                items: notes,
                onSelectNote: _setSelectedNote,
              )),
          if (_selectedNote != null)
            MaterialPage(
              key: ValueKey(_selectedNote?.id),
              child: NoteDetailsScreen(note: _selectedNote!),
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
