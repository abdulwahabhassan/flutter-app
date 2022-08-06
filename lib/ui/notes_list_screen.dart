import 'package:flutter/material.dart';
import 'package:flutter_app/ui/new_note_bottom_sheet.dart';
import '../model/note.dart';
import 'notes_app.dart';
import 'notes_app_bar.dart';

typedef ScrollToTopCallback = void Function(ScrollTo);

//WIDGET
class NotesListScreen extends StatefulWidget {
  const NotesListScreen(
      {Key? key,
      required this.notes,
      required this.onNoteSelected,
      required this.onNewNoteAdded,
      required this.onNoteDeleted,
      required this.onSearchStarted,
      required this.scrollController,
      required this.onScrollToTopClicked,
      required this.scrollIcon})
      : super(key: key);

  final List<Note> notes;
  final ValueChanged<Note> onNoteSelected;
  final ValueChanged<Note> onNewNoteAdded;
  final ValueChanged<Note> onNoteDeleted;
  final ValueChanged<String> onSearchStarted;
  final ScrollController scrollController;
  final ScrollToTopCallback onScrollToTopClicked;
  final IconData scrollIcon;

  @override
  State<NotesListScreen> createState() => _NotesListScreen();
}

class _NotesListScreen extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: NotesAppBar(
          onSearchStarted: widget.onSearchStarted,
          onScrollToTopClicked: widget.onScrollToTopClicked,
          listViewScrollController: widget.scrollController,
          scrollIcon: widget.scrollIcon),
      body: ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => widget.onNoteSelected(widget.notes[index]),
              leading: const CircleAvatar(
                child: Icon(Icons.sticky_note_2_outlined),
              ),
              title: Text(
                widget.notes[index].title,
                style: const TextStyle(inherit: true, fontSize: 15),
              ),
              trailing: IconButton(
                  onPressed: () {
                    widget.onNoteDeleted(widget.notes[index]);
                  },
                  icon: const Icon(Icons.delete_forever_rounded)),
              subtitle: Text(widget.notes[index].date ?? ""),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (builder) {
              return NewNoteBottomSheetWidget(
                  initialTitleText: null,
                  initialBodyText: null,
                  onSaveButtonClicked: widget.onNewNoteAdded);
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        },
        child: const Icon(Icons.edit_note_rounded),
      ),
    );
  }
}
