import 'package:flutter/material.dart';
import 'package:flutter_app/ui/new_note_bottom_sheet.dart';
import '../model/note.dart';

//WIDGET
class NotesListScreen extends StatelessWidget {
  const NotesListScreen({
    Key? key,
    required this.notes,
    required this.onNoteSelected,
    required this.onNewNoteAdded,
    required this.onNoteDeleted,
  }) : super(key: key);

  final List<Note> notes;
  final ValueChanged<Note> onNoteSelected;
  final ValueChanged<Note> onNewNoteAdded;
  final ValueChanged<Note> onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Notes"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.keyboard_double_arrow_up_rounded)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.grid_view_rounded))
        ],
        // bottom: TabBar(tabs: ),
        elevation: 0.0,
        scrolledUnderElevation: 2.0,
      ),
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
