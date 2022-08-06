import 'package:flutter/material.dart';
import 'package:flutter_app/ui/new_note_bottom_sheet.dart';
import '../model/note.dart';
import 'notes_app_bar.dart';

//WIDGET
class NotesListScreen extends StatelessWidget {
  const NotesListScreen({
    Key? key,
    required this.notes,
    required this.onNoteSelected,
    required this.onNewNoteAdded,
    required this.onNoteDeleted,
    required this.onSearchStarted,
  }) : super(key: key);

  final List<Note> notes;
  final ValueChanged<Note> onNoteSelected;
  final ValueChanged<Note> onNewNoteAdded;
  final ValueChanged<Note> onNoteDeleted;
  final ValueChanged<String> onSearchStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: NotesAppBar(onSearchStarted: onSearchStarted),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => onNoteSelected(notes[index]),
              leading: const CircleAvatar(
                child: Icon(Icons.sticky_note_2_outlined),
              ),
              title: Text(
                notes[index].title,
                style: const TextStyle(inherit: true, fontSize: 15),
              ),
              trailing: IconButton(
                  onPressed: () {
                    onNoteDeleted(notes[index]);
                  },
                  icon: const Icon(Icons.delete_forever_rounded)),
              subtitle: Text(notes[index].date ?? ""),
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
                  onSaveButtonClicked: onNewNoteAdded);
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
