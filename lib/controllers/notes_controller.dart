import 'package:flutter/material.dart';
import 'package:flutter_mvc_notes_app/models/note.dart';
import 'package:flutter_mvc_notes_app/models/notes_api.dart';
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
  NotesApi notesApi = NotesApi();
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

  void addNote({required BuildContext context}) async {
    _model.noteTitleController = TextEditingController();
    _model.noteContentController = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add a note"),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      visualDensity: VisualDensity.comfortable),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  label: const Text(
                    "Add a note",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      visualDensity: VisualDensity.standard,
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _model.noteTitleController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          labelText: "Note title",
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _model.noteContentController,
                      cursorColor: Theme.of(context).primaryColor,
                      minLines: 2,
                      maxLines: 10,
                      decoration: InputDecoration(
                          labelText: "Note content",
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
            )).then((value) {
      if (value != null) {
        if (value) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Note added")));
        }
      }
    });
  }

  void editNote(
      {required BuildContext context,
      // required ModelNotes note
      required Note note}) async {
    // note.noteTitleController.text = note.noteTitle;
    // note.noteContentController.text = note.noteDetails;
    _model.noteTitleController = TextEditingController(text: note.noteTitle!);
    _model.noteContentController =
        TextEditingController(text: note.noteDetails!);
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Edit note"),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      visualDensity: VisualDensity.comfortable),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  label: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      visualDensity: VisualDensity.standard,
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      // controller: note.noteTitleController,
                      controller: _model.noteTitleController,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          labelText: "Note title",
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      // controller: note.noteContentController,
                      controller: _model.noteContentController,
                      cursorColor: Theme.of(context).primaryColor,
                      minLines: 2,
                      maxLines: 10,
                      decoration: InputDecoration(
                          labelText: "Note content",
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
            )).then((value) {
      if (value != null) {
        if (value) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Note edited!")));
        }
      }
    });
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

  Future<void> onRefreshPage() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
