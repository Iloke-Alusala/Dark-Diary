import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Pages/note_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:diarydark/Services/quickPageRoute.dart';
import 'package:collection/collection.dart';

class note_view extends StatefulWidget {
  final Note? note;
  final Folder folder;
  final bool isNewNote;

  const note_view(
      {Key? key,
      required this.note,
      required this.folder,
      required this.isNewNote})
      : super(key: key);

  @override
  State<note_view> createState() => _note_viewState();
}

//List<Folder> allFolders = [Folder(name: "")];

final colors = AppColors();

class _note_viewState extends State<note_view> {
  /* The reason for not using a TextFormField is because we want to either save the note
  as it is or note because it was left empty. The form validator would give the user
  errors which goes against the aesthetic principle
  final _formKey = GlobalKey<FormState>();
   */
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  String newTitle = "";
  String newDescription = "";
  int newNumber = 0;
  int arwBut = 30;
  int shareBut = 30;
  String noFolder = "No Category";
  Folder currentFolder = Folder(size: 0, creation: DateTime.now(), name: "");
  Folder allNotesFolder = Folder(
      size: 10000, creation: DateTime.now(), name: "No Category", id: -1000000);

  var dropdownValue;

  Future refreshAllFolders() async {
    allFolders = await folderDB.instance.readAllFolders();
  }

  @override
  void initState() {
    refreshAllFolders();
    // Assign Current Folder to nothing if in allNotes
    if (widget.note!.folderid == null) {
      currentFolder = allNotesFolder;
    }
    // Otherwise assign to actual folder
    else {
      currentFolder = widget.folder;
    }
    //dropdownValue = currentFolder.name!;
    print("The current folder is: ${currentFolder.name}");

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';

    newTitle = widget.note!.title!;
    newDescription = widget.note!.description!;
    newNumber = widget.note!.number!;
    super.initState();
  }

  void updateCurrentFolder() async {
    if (widget.folder.id != null) {
      currentFolder = await folderDB.instance.getFolder(widget.folder.id);
      //print("New current folder is ${currentFolder.id}");
    } else {
      currentFolder = allNotesFolder;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool valid = true;
    refreshAllFolders();
    //dropdownValue = currentFolder.name!;
    updateCurrentFolder();
    //print("Current note folder is ${widget.folder.id}");

    return WillPopScope(
      onWillPop: () async {
        //Check if note is new
        if (widget.isNewNote) {
          // Is new note so check if it is in allNotes
          if (widget.folder.id == null) {
            // In allNotes so assign folder to No Category
            createNewNote(widget.isNewNote, valid, newTitle, newDescription,
                allNotesFolder);
          } else {
            // Not in allNotes so assign folder to pre-existing folder
            createNewNote(widget.isNewNote, valid, newTitle, newDescription,
                currentFolder);
          }
        } else {
          //print("popped and is not new note");
          // Old note in No Category(allNotes)
          if (widget.note!.folderid == -1000000) {
            updateNote(
                newTitle, newDescription, valid, allNotesFolder, widget.note!);
            // Update old note in current folder
          } else {
            updateNote(
                newTitle,
                newDescription,
                valid,
                await folderDB.instance.getFolder(widget.note!.folderid),
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
                child:
                    const Icon(Icons.arrow_back, size: 30, color: Colors.black),
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
                          newDescription, currentFolder);
                    }
                  } else {
                    //print("popped and is not new note");
                    //If the note is not new, update the old note
                    // -1000000 is the allNotes folder ID
                    if (widget.note!.folderid == -1000000) {
                      //print("Updating with allFolder stats");
                      updateNote(newTitle, newDescription, valid,
                          allNotesFolder, widget.note!);
                    } else {
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
                child: const Icon(Icons.share, size: 28, color: Colors.black),
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
            width: MediaQuery.of(context).size.width,
            height: 30, //should be 30, change this to get the overall height
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30, //should be 30
                          child: FutureBuilder<Widget>(
                            future: folderDropdown(
                                currentFolder, widget.note!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!;
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          //The code underneath is archaic code that is a simpler version of
                        //the current display, feel free to use it if you encounter performance
                        // issues ;)
                          /*(widget.folder.id == null)
                              // if in All Notes Page
                              ? (widget.isNewNote)
                                  // if the widget is a new note, then show the noFolder string, "uncategorised"
                                  ? FutureBuilder<Widget>(
                                      future: folderDropdown(
                                          currentFolder, widget.note!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data!;
                                        } else if (snapshot.hasError) {
                                          return Text("Error: ${snapshot.error}");
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    )
                                  /*Text(
                                      noFolder,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: colors.grey0,
                                          fontFamily: "euclid-circular-b"),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                           */
                                  // if the widget is not new, then check if its folder the
                                  // allFolder id. if not then search for folder from database
                                  : (widget.note!.folderid == -1000000)
                                      ? Text(
                                          noFolder,
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
                                                    fontFamily:
                                                        "euclid-circular-b"),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  "Error: ${snapshot.error}");
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        )
                              : Text(
                                  "${widget.folder.name}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: colors.grey0,
                                      fontFamily: "euclid-circular-b"),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                      */),
                    ),
                    SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox(
                        width:
                            (MediaQuery.of(context).size.width) * 0.5 / 1.5 - 32,
                        height: 30,
                        child: Text(
                          "• ${DateFormat.yMd().format(DateTime.now())}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: colors.grey0,
                              fontFamily: "euclid-circular-b"),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: NoteFormWidget(
              number: number,
              title: title,
              description: description,
              onChangedNumber: (number) => setState(() async {
                this.number = number;
                newNumber = number;
                Note newNote = Note(
                    description: newDescription,
                    creation: DateTime.now(),
                    folderid: currentFolder.id,
                    title: newTitle,
                    isImportant: false,
                    number: 0,
                    id: widget.note!.id);
                await notesDB.instance.update(newNote);
              }),
              onChangedTitle: (title) => setState(() {
                this.title = title;
                newTitle = title;
                Note newNote = Note(
                    description: newDescription,
                    creation: DateTime.now(),
                    folderid: currentFolder.id,
                    title: newTitle,
                    isImportant: false,
                    number: 0,
                    id: widget.note!.id);
                notesDB.instance.update(newNote);
              }),
              onChangedDescription: (description) => setState(() {
                this.description = description;
                newDescription = description;
                Note newNote = Note(
                    description: newDescription,
                    creation: DateTime.now(),
                    folderid: currentFolder.id,
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

  Future<DropdownButtonHideUnderline> folderDropdown(
      Folder curFolder, Note curNote) async {
    List<Folder> almostAllFolders = await folderDB.instance.readAllFolders();
    List<String> allFolders = almostAllFolders.map((x) => x.name!).toList();
    allFolders.add("No Category");
    dropdownValue = curFolder.name;
    //allFolders.removeAt(allFolders.indexOf(curFolder.name!));
    var seen = <String>{};
    allFolders = allFolders.where((x) => seen.add(x)).toList();
    //allFolders[allFolders.indexOf(currentFolder.name!)];
    /*
  print("fnd index, ${allFolders.indexOf(currentFolder.name!)}");
  if(allFolders.indexOf(currentFolder.name!)==-1){
    allFolders.insert(0, "uncategorised");
    dropdownValue = "uncategorised";
  }
  else{
    dropdownValue = allFolders[allFolders.indexOf(currentFolder.name!)];
  }
   */
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: dropdownValue,
        items: allFolders.map(
          (String x) {
            return DropdownMenuItem<String>(
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      size: 20,
                      color: colors.grey0,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 147,
                      child: Text(
                        "${x}",
                        style: TextStyle(
                            color: colors.grey0,
                            fontSize: 14,
                            fontFamily: "euclid-circular-b",
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                value: x,);
          },
        ).toList(),
        onChanged: (value) {
          dropdownValue = value;
          /*
          Attempt to seamlessly move note to another folder without having
          to store duplicate values
           */
          int folderIndex = allFolders.indexOf(value!);
          Note newNote = curNote.copy(folderid: almostAllFolders[folderIndex].id);
          notesDB.instance.delete(curNote);
          notesDB.instance.create(newNote);
          print("Now changing folder to ${almostAllFolders[folderIndex].name}");
          Navigator.pop(context);
          Navigator.of(context).push(quickPageRoute(child:note_view(
                note: curNote,
                folder: almostAllFolders[folderIndex],
                isNewNote: true)));

          //notesDB.instance.update(curNote)
        },
        hint: Text(
          "$dropdownValue",
          style: TextStyle(
              color: colors.grey0,
              fontSize: 14,
              fontFamily: "euclid-circular-b",
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis),
        ),
        buttonWidth: 60,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          color: colors.grey1,
          borderRadius: BorderRadius.circular(20),
        ).copyWith(
          boxShadow: kElevationToShadow[1],
        ),
        itemHeight: 60,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 250,
        dropdownWidth: 200,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: colors.grey1),
        isExpanded: true,

      ),
    );
    // Change color of dropdown as it is too distracting.
  }

  void _onDropDownChanged(String val) {
    setState(() {
      dropdownValue = val;
    });
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
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
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

  Widget buildDescription() => TextFormField(
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
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}

void createNewNote(
    bool isNew, bool valid, String title, String desc, Folder folder) async {
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
      await folderDB.instance.updateFolder(newFolder);
    }
  }
  folderDB.instance.updateSize();
}

// Potential fix for AllFolders problem is to add conditions for saving in here
// that would temporarily solve the solution in updateNote and createNote and would
//
void updateNote(
    String title, String desc, bool valid, Folder folder, Note note) async {
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
    await folderDB.instance.updateFolder(newFolder);
    print(
        "Updated Note name: ${newNote.title}, Folder size: ${newFolder.size}");
  }
}
