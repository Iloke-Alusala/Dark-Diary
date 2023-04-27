import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Models/Note.dart';
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
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

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

  Future<List<Folder>> readAllFolders() async {
    final db = await instance.database;

    const orderBy = '${FolderFields.time} desc';
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

  Future<List<String>> getFoldersNames()async{
    List<Folder> result = await folderDB.instance.readAllFolders();
    return result.map((x) => x.name!).toList();
  }

  Future<int> delete(dynamic id) async {
    final db = await instance.database;
    final notes = await notesDB.instance.inFolder(id);
    for (var x in notes) {
      notesDB.instance.delete(x.id);
    }
    final result = await db
        .delete(tableFolder, where: '${FolderFields.id} = ?', whereArgs: [id]);
    //print("successfully deleted: ${result}");
    return result;
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
    //There was a major bug here, where I was comparing the notes list
    Map<int?, dynamic> mp = {};
    for (int i = 0; i < folderList.length; ++i) {
      final result = await db.rawQuery(
          'SELECT Count(*) FROM $tableNote Where ${NoteFields.folderid} = "${folderList[i].id}"');
      mp[folderList[i].id] = result[0]["Count(*)"];
      //print("The folder count for ${folderList[i].name} is : ${result[0]["Count(*)"]}");
      //print("${mp[notesList[i].id]} is the count");
    }

    folderList.forEach((x) async{
      //print("Folder size: ${mp[x.id]}");
      Folder newFolder = x.copy(size: mp[x.id]);
      //print("Folder ${x.name} has a size ${x.size}");
      await update(newFolder);
      //print("Python Folder: ${newFolder.name} and size ${newFolder.size}");
    });
  }
  
  Future updateFolder(Folder inFolder) async{
    final db = await folderDB.instance.database;
    //print("${inFolder.creation}");
    db.rawQuery("Update $tableFolder Set ${FolderFields.time} = ${DateTime.now()} where ${FolderFields.id} = ${inFolder.id}");
    updateSize();
    //widgetFolderView.refreshFolders();
    //print("${inFolder.creation}");
  }
}
