import 'package:flutter/material.dart';
import 'package:flutter_app/ui/notes_app.dart';

import 'notes_list_screen.dart';

class NotesAppBar extends StatefulWidget with PreferredSizeWidget {
  const NotesAppBar({Key? key,
    required this.onSearchStarted,
    required this.onScrollToTopClicked,
    required this.listViewScrollController,
    required this.scrollIcon})
      : super(key: key);

  final ValueChanged<String> onSearchStarted;
  final ScrollToTopCallback onScrollToTopClicked;
  final ScrollController listViewScrollController;
  final IconData scrollIcon;

  @override
  State<NotesAppBar> createState() => _NotesAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _NotesAppBar extends State<NotesAppBar> {
  bool search = false;
  late final TextEditingController searchBarController;

  toggleSearch(bool value) {
    setState(() {
      search = value;
    });
  }

  @override
  void initState() {
    super.initState();
    searchBarController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      title: search
          ? TextFormField(
        controller: searchBarController,
        onChanged: (text) => {widget.onSearchStarted(text)},
        style: const TextStyle(
            inherit: true, fontSize: 15, fontWeight: FontWeight.normal),
        decoration: const InputDecoration(
          hintStyle: TextStyle(
              inherit: true, fontSize: 15, fontWeight: FontWeight.normal),
          isDense: true,
          border: InputBorder.none,
          hintText: 'Type to search..',
        ),
      )
          : const Text("Notes"),
      actions: [
        IconButton(
          onPressed: () {
            toggleSearch(!search);
            if (!search) {
              widget.onSearchStarted("");
              searchBarController.clear();
            }
          },
          icon: search
              ? const Icon(Icons.cancel)
              : const Icon(Icons.search_rounded),
        ),
        IconButton(
            onPressed: () {
              widget.scrollIcon == Icons.keyboard_double_arrow_down_rounded
                  ? widget.onScrollToTopClicked(ScrollTo.bottom)
                  : widget.onScrollToTopClicked(ScrollTo.top);
            },
            icon: Icon(widget.scrollIcon)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view_rounded))
      ],
      // bottom: TabBar(tabs: ),
      elevation: 0.0,
      scrolledUnderElevation: 2.0,
    );
  }
}
