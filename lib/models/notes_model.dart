import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ModelNotes extends ModelMVC {
  ModelNotes(
      [StateMVC? state,
      this.id = 0,
      this.noteTitle = "",
      this.noteDetails = ""])
      : super(state);

  int id = 0;
  String noteTitle = "";
  String noteDetails = "";
  TextEditingController noteTitleController=TextEditingController();
  TextEditingController noteContentController=TextEditingController();
}
