import 'package:flutter/material.dart';

Widget newNoteBottomSheet(BuildContext context) => Container(
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
            const TextField(
              decoration: InputDecoration(
                isDense: true,
                icon: Icon(Icons.title_rounded),
                border: UnderlineInputBorder(),
                hintText: 'What will you title this note?',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              child: const TextField(
                maxLines: 7,
                minLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
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
                  onPressed: () {},
                  child: const Text("Save"),
                ))
          ],
        ),
      ),
    );
