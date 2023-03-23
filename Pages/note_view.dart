import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Pages/note_page.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class note_view extends StatefulWidget {
  final Note? note;
  final Folder folder;
  final bool isNewNote;

  const note_view({Key? key,
    required this.note,
    required this.folder,
    required this.isNewNote})
      : super(key: key);

  @override
  State<note_view> createState() => _note_viewState();
}

final colors = AppColors();

class _note_viewState extends State<note_view> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  String newTitle = "";
  String newDescription = "";
  int newNumber = 0;
  int arwBut = 30;
  int shareBut = 30;
  String noFolder = "uncategorised";
  Folder currentFolder = Folder(size: 0, creation: DateTime.now(), name: "");
  Folder allNotesFolder = Folder(
      size: 10000,
      creation: DateTime.now(),
      name: "uncategorised",
      id: -1000000);

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';

    newTitle = widget.note!.title!;
    newDescription = widget.note!.description!;
    newNumber = widget.note!.number!;
  }

  void updateCurrentFolder() async {
    if (widget.folder.id != null) {
      currentFolder = await folderDB.instance.getFolder(widget.folder.id);
      print("New current folder is ${currentFolder.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool valid = true;
    updateCurrentFolder();
    print("Current note folder is ${widget.folder.id}");

    return WillPopScope(
      onWillPop: () async {
        //Check if note is new
        if (widget.isNewNote) {
          if (widget.folder.id == null) {
            createNewNote(widget.isNewNote, valid, newTitle, newDescription,
                allNotesFolder);
          } else {
            createNewNote(widget.isNewNote, valid, newTitle, newDescription,
                widget.folder);
          }
        } else {
          print("popped and is not new note");
          //If the note is not new, update the old note
          if (widget.note!.folderid == -1000000) {
            updateNote(
                newTitle,
                newDescription,
                valid,
                allNotesFolder,
                widget.note!);
          }
          else {
            updateNote(
                newTitle,
                newDescription,
                valid,
                await folderDB.instance
                    .getFolder(widget.note!.folderid),
                widget.note!);
          }
        }
        Navigator.of(context).pop(true);
        return true;
      },
      child: Scaffold(
        backgroundColor: colors.grey2,
        appBar: AppBar(
          backgroundColor: colors.grey2,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: GestureDetector(
                child: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onTap: () async {
                  //This should have the same operations as WIllPopScope, because
                  //WIllPopScope only runs when you press back_button not when you actually
                  //pop the screen
                  if (widget.isNewNote) {
                    if (widget.folder.id == null) {
                      createNewNote(widget.isNewNote, valid, newTitle,
                          newDescription, allNotesFolder);
                    } else {
                      createNewNote(widget.isNewNote, valid, newTitle,
                          newDescription, widget.folder);
                    }
                  } else {
                    print("popped and is not new note");
                    //If the note is not new, update the old note
                    // -1000000 is the allNotes folder ID
                    if (widget.note!.folderid == -1000000) {
                      print("Updating with allFolder stats");
                      updateNote(
                          newTitle,
                          newDescription,
                          valid,
                          allNotesFolder,
                          widget.note!);
                    }
                    else {
                      updateNote(
                          newTitle,
                          newDescription,
                          valid,
                          await folderDB.instance
                              .getFolder(widget.note!.folderid),
                          widget.note!);
                    }
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: GestureDetector(
                child: Icon(Icons.share, size: 28, color: Colors.black),
                onTap: () {
                  Share.share(
                      '${widget.note!.title}\n\n${widget.note!.description}');
                },
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Column(children: [
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5 - 10,
                      height: 30,
                      child: (widget.folder.id == null)
                      // if in All Notes Page
                          ? (widget.isNewNote)
                      // if the widget is a new note, then show the noFolder string, "uncategorised"
                          ? Text(
                        "${noFolder}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colors.grey0,
                            fontFamily: "euclid-circular-b"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                      // if the widget is not new, then check if its folder the
                      // allFolder id. if not then search for folder from database
                          :
                      (widget.note!.folderid == -1000000) ?
                      Text(
                        "${noFolder}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colors.grey0,
                            fontFamily: "euclid-circular-b"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                          : FutureBuilder<Folder>(
                        future: folderDB.instance
                            .getFolder(widget.note!.folderid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data!.name}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: colors.grey0,
                                  fontFamily: "euclid-circular-b"),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ) : Text(
                        "${widget.folder.name}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colors.grey0,
                            fontFamily: "euclid-circular-b"),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ),
                    SizedBox(
                      width:
                      (MediaQuery
                          .of(context)
                          .size
                          .width) * 0.5 / 1.5 - 32,
                      height: 30,
                      child: Text(
                        "• ${DateFormat.yMd().format(DateTime.now())}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: colors.grey0,
                            fontFamily: "euclid-circular-b"),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            child: NoteFormWidget(
              number: number,
              title: title,
              description: description,
              onChangedNumber: (number) =>
                  setState(() async {
                    this.number = number;
                    newNumber = number;
                    Note newNote = Note(
                        description: newDescription,
                        creation: DateTime.now(),
                        folderid: widget.folder.id,
                        title: newTitle,
                        isImportant: false,
                        number: 0,
                        id: widget.note!.id);
                    await notesDB.instance.update(newNote);
                  }),
              onChangedTitle: (title) =>
                  setState(() {
                    this.title = title;
                    newTitle = title;
                    Note newNote = Note(
                        description: newDescription,
                        creation: DateTime.now(),
                        folderid: widget.folder.id,
                        title: newTitle,
                        isImportant: false,
                        number: 0,
                        id: widget.note!.id);
                    notesDB.instance.update(newNote);
                  }),
              onChangedDescription: (description) =>
                  setState(() {
                    this.description = description;
                    newDescription = description;
                    Note newNote = Note(
                        description: newDescription,
                        creation: DateTime.now(),
                        folderid: widget.folder.id,
                        title: newTitle,
                        isImportant: false,
                        number: 0,
                        id: widget.note!.id);
                    notesDB.instance.update(newNote);
                  }),
            ),
          )
        ]),
      ),
    );
  }
}

class NoteFormWidget extends StatelessWidget {
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: title,
      style: TextStyle(
          color: colors.black0,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          fontFamily: "euclid-circular-b"),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: colors.grey1),
      ),
      validator: (title) =>
      title != null && title.isEmpty ? 'The title cannot be empty' : null,
      onChanged: onChangedTitle,
    );
  }

  Widget buildDescription() =>
      TextFormField(
        initialValue: description,
        //Allows for overflow to new line of TextField and wraps around it
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: TextStyle(
            color: colors.grey0,
            fontSize: 16,
            fontFamily: "euclid-circular-b",
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: colors.grey1),
        ),
        validator: (title) =>
        title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}

void createNewNote(bool isNew, bool valid, String title, String desc,
    Folder folder) async {
  //Check if note is new
  if (isNew) {
    //if title empty, copy from description
    if (title.isEmpty) {
      //if description is empty, don't create new note
      if (desc.isEmpty) {
        valid = false;
      } else {
        title = desc.substring(0, min(desc.length, 20));
      }
    }
    //print("desc is: ${desc}");
    Note newNote = Note(
      description: desc,
      creation: DateTime.now(),
      folderid: folder.id!,
      title: title,
      isImportant: false,
      number: 0,
    );
    Folder newFolder = folder.copy(createdTime: DateTime.now());
    if (valid) {
      //print("note created in : ${folder.name}");
      await notesDB.instance.create(newNote);
      await folderDB.instance.update(newFolder);
    }
  }
  folderDB.instance.updateSize();
}

// Potential fix for AllFolders problem is to add conditions for saving in here
// that would temporarily solve the solution in updateNote and createNote and would
//
void updateNote(String title, String desc, bool valid, Folder folder,
    Note note) async {
  //A function to update a note when you move from note_view to note_page
  Note newNote = Note(
      description: desc,
      creation: DateTime.now(),
      folderid: folder.id!,
      title: title,
      isImportant: false,
      number: 0,
      id: note.id);
  Folder newFolder = folder.copy(createdTime: DateTime.now());
  if (valid) {
    await notesDB.instance.update(newNote);
    await folderDB.instance.update(newFolder);
  }
}
