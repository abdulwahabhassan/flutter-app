import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

import 'model.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key, required this.items, required this.onSelectNote})
      : super(key: key);

  final List<Note> items;
  final ValueChanged<Note> onSelectNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Flutter"),
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
        onPressed: () {},
        child: const Icon(Icons.edit_note_rounded),
      ),
      // drawer: ,
      // bottomNavigationBar: ,
      // bottomSheet: ,
    );
  }
}
