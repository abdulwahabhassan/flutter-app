import 'package:flutter/material.dart';
import 'package:flutter_app/route_navigation/note_route_path.dart';
import 'package:flutter_app/notes_page.dart';

import '../model.dart';
import '../note_details_page.dart';

class NoteRouterDelegate extends RouterDelegate<NoteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NoteRoutePath> {

  NoteRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  Note? _selectedNote;
  List<Note> notes = Note.notes;

  void _setSelectedNote(Note note) {
    _selectedNote = note;
    notifyListeners();
  }

  void _unsetSelectedNote() {
    _selectedNote = null;
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  NoteRoutePath get currentConfiguration {
    return _selectedNote == null
        ? NoteRoutePath.notes()
        : NoteRoutePath.details(notes.indexOf(_selectedNote!));
  }


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: const ValueKey("NotesPage"),
            child: NotesPage(
              items: notes,
              onSelectNote: _setSelectedNote,
            )),
        if (_selectedNote != null)
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
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NoteRoutePath configuration) async {
    if (configuration.isDetailsPage) {
      _selectedNote = notes[configuration.id!];
    } else if (configuration.isNotesPage) {
      _selectedNote = null;
    }

  }

}
