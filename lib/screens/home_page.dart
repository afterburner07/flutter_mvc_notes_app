import 'package:flutter/material.dart';
import 'package:flutter_mvc_notes_app/controllers/notes_controller.dart';
import 'package:flutter_mvc_notes_app/repositories/notes_repository.dart'
    as notes_repository;
import 'package:mvc_pattern/mvc_pattern.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  StateMVC<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  _MyHomePageState() : super(ControllerNotes()) {
    /// Acquire a reference to the particular Controller.
    _con = controller as ControllerNotes;
  }
  late ControllerNotes _con;

  @override
  void initState() {
    super.initState();
    _con.initState();
    getNotesList();
  }

  void getNotesList() async {
    _con.notesApi = await notes_repository.getNotesListFromAPI(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getNotesList();
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 15),
          // itemCount: _con.notesList.length
          itemCount:
              _con.notesApi.notes == null ? 0 : _con.notesApi.notes!.length
          // 2
          ,
          itemBuilder: (context, index) => ListTile(
            visualDensity: VisualDensity.comfortable,
            title: Text(
              // _con.notesList[index].noteTitle
              _con.notesApi.notes![index].noteTitle!,
              // "Note title"
            ),
            subtitle: Text(
                // _con.notesList[index].noteDetails),
                _con.notesApi.notes![index].noteDetails!),
            leading: IconButton(
              icon: Icon(Icons.edit_outlined,
                  color: Theme.of(context).primaryColor),
              tooltip: "Edit this note",
              onPressed: () {
                // _con.editNote(context: context, note: _con.notesList[index]);
                _con.editNote(
                    context: context, note: _con.notesApi.notes![index]);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              tooltip: "Remove this note",
              onPressed: () {
                _con.removeNote(index);
              },
            ),
            onLongPress: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Tap here to show details of this note")));
            },
            onTap: () {
              _con.viewNoteDetails(
                  _con.notesList[index].id,
                  _con.notesList[index].noteTitle,
                  _con.notesList[index].noteDetails,
                  context);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _con.addNote(context: context);
        }
        // _incrementCounter
        ,
        tooltip: 'Add a new note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
