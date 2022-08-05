import 'package:flutter/material.dart';

import '../model/note.dart';

typedef SavedCallback = void Function(String titleText, String bodyText);

//WIDGET
class NewNoteBottomSheetWidget extends StatefulWidget {
  const NewNoteBottomSheetWidget(
      {Key? key,
      required this.initialTitleText,
      required this.initialBodyText,
      required this.onSaveButtonClicked})
      : super(key: key);

  final String? initialTitleText;
  final String? initialBodyText;
  final ValueChanged<Note> onSaveButtonClicked;

  @override
  State<NewNoteBottomSheetWidget> createState() => _NewNoteBottomSheetState();
}

//STATE
class _NewNoteBottomSheetState extends State<NewNoteBottomSheetWidget> {
  late final TextEditingController _titleTextController;
  late final TextEditingController _bodyTextController;

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController(text: widget.initialTitleText);
    _bodyTextController = TextEditingController(text: widget.initialBodyText);
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextController.dispose();
    _bodyTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.887,
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
      child: Center(
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.horizontal_rule_rounded)),
            TextFormField(
              controller: _titleTextController,
              style: const TextStyle(
                  inherit: true, fontSize: 15, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    inherit: true, fontSize: 15, fontWeight: FontWeight.normal),
                isDense: true,
                icon: Icon(Icons.title_rounded),
                border: UnderlineInputBorder(),
                hintText: 'What will you title this note?',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              child: TextFormField(
                controller: _bodyTextController,
                style: const TextStyle(inherit: true, fontSize: 15),
                maxLines: 7,
                minLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  isDense: true,
                  icon: Icon(Icons.notes_rounded),
                  border: UnderlineInputBorder(),
                  hintText: 'Now let your ideas flow..',
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSaveButtonClicked(Note(
                        title: _titleTextController.text,
                        body: _bodyTextController.text));
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ))
          ],
        ),
      ),
    );
  }
}
