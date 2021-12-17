import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvc_notes_app/models/notes_api.dart';
import 'package:flutter_mvc_notes_app/utils/globals.dart';
import 'package:http/http.dart' as http;

Future<NotesApi> getNotesListFromAPI(BuildContext context) async {
  final response = await http.get(
    Uri.parse(Globals.baseUrl + 'api/notes'),
    headers: {"Accept": "application/json"},
  );

  print(response.body);
  final responseJson = jsonDecode(response.body);
  NotesApi notesApi = NotesApi();
  notesApi = NotesApi.fromJson(responseJson);
  if (!notesApi.success!) {
    if (notesApi.notes == null || notesApi.notes!.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(notesApi.message!),
        duration: const Duration(seconds: 1),
      ));
    } else {}
  }
  return notesApi;
}
