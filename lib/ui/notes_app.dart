import 'package:flutter/material.dart';

import '../database/sqlite_helper.dart';
import '../model/note.dart';
import 'note_details_screen.dart';
import 'notes_list_screen.dart';

//WIDGET
class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

//STATE
class _NotesAppState extends State<NotesApp> {
  Note? _selectedNote;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: [
          MaterialPage(
              key: const ValueKey("homePage"),
              child: NotesListScreen(
                onNoteSelected: _setSelectedNote,
                onNewNoteAdded: _addNewNote,
                onNoteDeleted: _deleteNote,
                notes: notes,
              )),
          if (_selectedNote != null)
            MaterialPage(
              key: ValueKey(_selectedNote?.id),
              child: NoteDetailsScreen(
                note: _selectedNote!,
                onNoteUpdated: _updateNote,
              ),
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

  Future<void> _fetchNotes() async {
    final data = await SQLiteHelper.getNotes();
    setState(() {
      notes = data;
    });
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

  Future<void> _addNewNote(Note note) async {
    await SQLiteHelper.insertNote(note);
    _fetchNotes();
  }

  Future<void> _deleteNote(Note note) async {
    if (note.id != null) {
      await SQLiteHelper.deleteNote(note.id!);
    }
    _fetchNotes();
  }

  Future<void> _updateNote(Note note) async {
    await SQLiteHelper.updateNote(note);
    _fetchNotes();
    _setSelectedNote(note);
  }
}
