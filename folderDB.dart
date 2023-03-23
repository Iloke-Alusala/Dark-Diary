import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Models/Note.dart';
import 'dart:convert';
import 'package:diarydark/Pages/folder_view.dart';
//The Database Provider Class

class folderDB {
  static final folderDB instance = folderDB._init();

  static Database? _database;

  folderDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('folder.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableFolder ( 
  ${FolderFields.id} $idType, 
  ${FolderFields.name} $textType,
  ${FolderFields.time} $textType,
  ${FolderFields.size} $integerType
  )
''');
  }

  Future<Folder> create(Folder folder) async {
    final db = await instance.database;
    final id = await db.insert(tableFolder, folder.toJson());
    return folder.copy(id: id);
  }

  Future<Folder> getFolder(int? folderID)async{
    final db =  await instance.database;
    final result = await db.query(tableFolder, where: "${FolderFields.id} = $folderID");
    return Folder.fromJson(result[0]);
  }

/*
  Future<Folder> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFolder,
      columns: FolderFields.values,
      //values in 'whereArgs' stand in place of '?'
      //This syntax prevents SQL injections
      where: '${FolderFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    else {
      throw Exception('Id $id could not be found :/');
    }
  }
*/
  Future<List<Folder>> readAllFolders() async {
    final db = await instance.database;

    final orderBy = '${FolderFields.time} desc';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableFolder, orderBy: orderBy);

    return result.map((json) => Folder.fromJson(json)).toList();
  }

  Future<int> update(Folder folder) async {
    final db = await instance.database;

    db.update(
      tableFolder,
      folder.toJson(),
      where: '${FolderFields.id} = ?',
      whereArgs: [folder.id],
    );
    widgetFolderView.refreshFolders();
    return 1;
  }

  Future<int> delete(dynamic id) async {
    final db = await instance.database;
    return await db
        .delete(tableFolder, where: '${FolderFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future updateSize() async {
    //This updates the size of the folders
    //First read notes and folders into a final list
    final notesList = await notesDB.instance.readAllNotes();
    final folderList = await folderDB.instance.readAllFolders();
    //initialise the database
    final db = await notesDB.instance.database;

    //Create the map to store note ids and their amount
    Map<int?, dynamic> mp = {};
    for (int i = 0; i < notesList.length; ++i) {
      final result = await db.rawQuery(
          'SELECT Count(*) FROM ${tableNote} Where ${NoteFields.folderid} = "${notesList[i].id}"');
      final parsedRes = result;
      mp[notesList[i].id] = result[0]["Count(*)"];
      //print(mp[notesList[i].id]);
    }

    folderList.forEach((x) {
      //print("Folder size: ${mp[x.id]}");
      Folder newFolder = x.copy(size: mp[x.id]);
      update(newFolder);
      //print("Python Folder: ${newFolder.name} and size ${newFolder.size}");
    });
  }
  
  Future updateFolder(Folder inFolder) async{
    final db = await folderDB.instance.database;
    print("${inFolder.creation}");
    db.rawQuery("Update $tableFolder Set ${FolderFields.time} = ${DateTime.now()} where ${FolderFields.id} = ${inFolder.id}");
    widgetFolderView.refreshFolders();
    print("${inFolder.creation}");
  }
}
