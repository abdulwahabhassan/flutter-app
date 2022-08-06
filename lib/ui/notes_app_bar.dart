import 'package:flutter/material.dart';

class NotesAppBar extends StatefulWidget with PreferredSizeWidget {
  const NotesAppBar({Key? key, required this.onSearchStarted})
      : super(key: key);

  final ValueChanged<String> onSearchStarted;

  @override
  State<NotesAppBar> createState() => _NotesAppBar();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _NotesAppBar extends State<NotesAppBar> {
  bool search = false;
  late final TextEditingController searchBarController;

  activateSearch(bool value) {
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
          ? const Text("Notes")
          : TextFormField(
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
            ),
      actions: [
        IconButton(
            onPressed: () {
              search
                  ? activateSearch(false)
                  : {
                      activateSearch(true),
                      widget.onSearchStarted(""),
                      searchBarController.clear()
                    };
            },
            icon: search
                ? const Icon(Icons.search_rounded)
                : const Icon(Icons.cancel)),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_double_arrow_up_rounded)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view_rounded))
      ],
      // bottom: TabBar(tabs: ),
      elevation: 0.0,
      scrolledUnderElevation: 2.0,
    );
  }
}
