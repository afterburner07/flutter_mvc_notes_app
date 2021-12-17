import 'package:flutter/material.dart';
import 'package:flutter_mvc_notes_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter MVC pattern note app'),
    );
  }
}
