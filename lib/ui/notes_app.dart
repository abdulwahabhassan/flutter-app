import 'package:flutter/material.dart';

import '../database/sqlite_helper.dart';
import '../model/note.dart';
import 'note_details_screen.dart';
import 'notes_list_screen.dart';

enum ScrollTo { top, bottom }

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
  late ScrollController _scrollController = ScrollController();
  IconData _scrollIcon = Icons.keyboard_double_arrow_down_rounded;

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      setState(() {
        _scrollIcon = Icons.keyboard_double_arrow_up_rounded;
      });
    }
    if (_scrollController.offset <= _scrollController.position.minScrollExtent) {
      setState(() {
        _scrollIcon = Icons.keyboard_double_arrow_down_rounded;
      });
    }
  }

  // This is what you're looking for!
  void _scrollToTop(ScrollTo scrollTo) {
    setState(() {
      _scrollController.animateTo(
        scrollTo == ScrollTo.top ? 0.00 : _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
      );
    });

  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
                scrollIcon: _scrollIcon,
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
    _scrollToTop(ScrollTo.top);
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
