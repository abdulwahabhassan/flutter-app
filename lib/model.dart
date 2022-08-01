import 'dart:ffi';

class Note {
  Note(
      {required this.id,
      required this.title,
      required this.body,
      required this.date});

  final int id;
  final String title;
  final String body;
  final String date;

  static final List<Note> notes = [
    Note(
        id: 1,
        title: "Food for Thought",
        body:
            "Trying to find me peace of mind led me searching for answers in all the wrong places that I shouldn't have.",
        date: "2022-01-01"),
    Note(
        id: 2,
        title: "100 Reasons to Colonize Mars",
        body:
            "Mars is the new rave. But amidst all the media hype, are there any genuine and valid reasons as to why we should colonize mars.",
        date: "2022-08-02"),
    Note(
        id: 3,
        title: "Blood and Water",
        body:
            "It is often said that blood is thicker than water. I would however like to interpret this sentence in a much different context that we can all relate to and realize that the case is not always true. ",
        date: "2022-04-04"),
    Note(
        id: 4,
        title: "Food for Thought",
        body:
            "Trying to find me peace of mind led me searching for answers in all the wrong places that I shouldn't have.",
        date: "2022-01-01"),
    Note(
        id: 5,
        title: "100 Reasons to Colonize Mars",
        body:
            "Mars is the new rave. But amidst all the media hype, are there any genuine and valid reasons as to why we should colonize mars.",
        date: "2022-08-02"),
    Note(
        id: 6,
        title: "Blood and Water",
        body:
            "It is often said that blood is thicker than water. I would however like to interpret this sentence in a much different context that we can all relate to and realize that the case is not always true. ",
        date: "2022-04-04"),
    Note(
        id: 7,
        title: "Food for Thought",
        body:
            "Trying to find me peace of mind led me searching for answers in all the wrong places that I shouldn't have.",
        date: "2022-01-01"),
    Note(
        id: 8,
        title: "100 Reasons to Colonize Mars",
        body:
            "Mars is the new rave. But amidst all the media hype, are there any genuine and valid reasons as to why we should colonize mars.",
        date: "2022-08-02"),
    Note(
        id: 9,
        title: "Blood and Water",
        body:
            "It is often said that blood is thicker than water. I would however like to interpret this sentence in a much different context that we can all relate to and realize that the case is not always true. ",
        date: "2022-04-04"),
    Note(
        id: 10,
        title: "Blood and Water",
        body:
            "It is often said that blood is thicker than water. I would however like to interpret this sentence in a much different context that we can all relate to and realize that the case is not always true. ",
        date: "2022-04-04"),
    Note(
        id: 11,
        title: "Food for Thought",
        body:
            "Trying to find me peace of mind led me searching for answers in all the wrong places that I shouldn't have.",
        date: "2022-01-01"),
    Note(
        id: 12,
        title: "100 Reasons to Colonize Mars",
        body:
            "Mars is the new rave. But amidst all the media hype, are there any genuine and valid reasons as to why we should colonize mars.",
        date: "2022-08-02"),
    Note(
        id: 13,
        title: "Blood and Water",
        body:
            "It is often said that blood is thicker than water. I would however like to interpret this sentence in a much different context that we can all relate to and realize that the case is not always true. ",
        date: "2022-04-04")
  ];
}
