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
  List<Note> _notes = [];
  late ScrollController _scrollController;

  // This is what you're looking for!
  void _scrollToTop() {
    _scrollController.animateTo(
      0.00,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
                onSearchStarted: _filterNotes,
                scrollController: _scrollController,
                onScrollToTopClicked: _scrollToTop,
                notes: _notes,
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
      theme: ThemeData(
          primarySwatch: Colors.grey,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black)),
    );
  }

  Future<void> _fetchNotes() async {
    final data = await SQLiteHelper.getNotes();
    setState(() {
      _notes = data;
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

  Future<void> _filterNotes(String searchQuery) async {
    List<Note> notes = await SQLiteHelper.getNotes();
    List<Note> filteredNotes = notes.where((element) =>
    element.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        element.body.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    setState(() {
      _notes = filteredNotes;
    });
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
