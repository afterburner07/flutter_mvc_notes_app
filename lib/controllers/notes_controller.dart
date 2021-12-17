import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mvc_notes_app/models/notes_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ControllerNotes extends ControllerMVC {
  factory ControllerNotes([StateMVC? state]) =>
      _this ??= ControllerNotes._(state);
  ControllerNotes._(StateMVC? state) : super(state);
  static ControllerNotes? _this;

  late ModelNotes _model;
  List<ModelNotes> notesList = [];
  StateMVC<StatefulWidget>? get stateMVC => null;
  @override
  void initState() {
    _model = ModelNotes(stateMVC);
    notesList = [
      ModelNotes(state, 0, "Note title 1", "Note description 1"),
      ModelNotes(state, 1, "Note title 2", "Note description 2"),
      ModelNotes(state, 2, "Note title 3", "Note description 3"),
      ModelNotes(state, 3, "Note title 4", "Note description 4"),
      ModelNotes(state, 4, "Note title 5", "Note description 5"),
      ModelNotes(state, 5, "Note title 6", "Note description 6"),
    ];
  }

  void addNote() {
    print("Add note functionality");
  }

  void editNote() {
    print("Edit note functionality");
  }

  void removeNote(int index) {
    setState(() {
      notesList.removeAt(index);
    });
  }

  void viewNoteDetails(
      int id, String noteTitle, String noteDescription, BuildContext context) {
    print(id);
    print(noteTitle);
    print(noteDescription);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Note details"),
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Title: "),
                        Divider(color: Theme.of(context).primaryColor),
                        Text(noteTitle),
                        const SizedBox(height: 30),
                        const Text("Description: "),
                        Divider(color: Theme.of(context).primaryColor),
                        Text(noteDescription),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ));
  }
}
