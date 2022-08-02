import 'package:flutter/material.dart';

import 'model/note.dart';


class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          note.title,
          style: const TextStyle(inherit: true, fontSize: 18),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_a_photo_rounded))
        ],
        // bottom: TabBar(tabs: ),
        elevation: 0.0,
        scrolledUnderElevation: 2.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                    inherit: true, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Text(
                      note.body,
                      style: const TextStyle(
                          inherit: true,
                          fontSize: 15),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        note.date,
                        style: const TextStyle(
                            inherit: true,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
