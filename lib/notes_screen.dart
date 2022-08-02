import 'package:flutter/material.dart';
import 'package:flutter_app/new_note_bottom_sheet.dart';
import 'model/note.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key, required this.items, required this.onSelectNote})
      : super(key: key);

  final List<Note> items;
  final ValueChanged<Note> onSelectNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Notes"),
        actions: [
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
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => onSelectNote(items[index]),
              leading: const CircleAvatar(
                child: Icon(Icons.sticky_note_2_outlined),
              ),
              title: Text(items[index].title),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever_rounded)),
              subtitle: Text(items[index].date),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (builder) {
              return newNoteBottomSheet(context);
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
