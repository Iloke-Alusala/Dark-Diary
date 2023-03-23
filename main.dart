import 'package:flutter/material.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Pages/note_page.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Models/Folder.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/note_page': (context) => note_page(),
      },
      initialRoute: '/note_page',
    );
  }
}
