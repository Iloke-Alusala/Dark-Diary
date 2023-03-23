import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Models/Note.dart';
//The Database Provider Class

class notesDB {
  static final notesDB instance = notesDB._init();

  static Database? _database;

  notesDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
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
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final nullIntegerType = "INTEGER";

    await db.execute('''
CREATE TABLE $tableNote ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType,
  ${NoteFields.folderid} $nullIntegerType  
  )
''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNote, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNote,
      columns: NoteFields.values,
      //values in 'whereArgs' stand in place of '?'
      //This syntax prevents SQL injections
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    else {
      throw Exception('Id $id could not be found :/');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNote, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> allNotesSize() async{
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db.rawQuery("Select count(${NoteFields.id}) from ${tableNote}");
    //print("semi-result is: ${result[0]["count(_id)"]}");
    List<Note> notes = await readAllNotes();
    return notes.length;
  }

  Future<List<Note>> inFolder(dynamic folderId) async {

    final db = await instance.database;

    final orderBy = "${NoteFields.time} ASC";

    final result = await db.query(tableNote, orderBy: orderBy, where: '${NoteFields.folderid} = "${folderId}"');
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNote,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(dynamic id) async {
    final db = await instance.database;
    return await db.delete(
        tableNote,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}