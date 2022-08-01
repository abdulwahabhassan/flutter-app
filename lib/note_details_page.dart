import 'package:flutter/material.dart';

import 'model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(note.title),
            Text(note.body),
            Text(note.date),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))
          ],
        ),
      ),
    );
  }
}
