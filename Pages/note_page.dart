import 'dart:ui';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Widgets/addFolderButton.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Widgets/smallNote.dart';
import 'package:diarydark/Widgets/longNote.dart';
import 'package:diarydark/Widgets/wideNote.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Widgets/addNoteButton.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Pages/folder_display.dart';
import 'package:diarydark/Services/SlideupPageRoute.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'panelWidget.dart';

class note_page extends StatefulWidget {
  const note_page({Key? key}) : super(key: key);

  @override
  State<note_page> createState() => _note_pageState();
}

List<Note> notes = [];
bool isLoading = false;
bool ispressed = false;
List<Folder> allFolders = [];
final colors = AppColors();
Folder currentFolder = Folder(name: "All Notes", creation: DateTime.now(), size: 0);

class _note_pageState extends State<note_page> {
  @override
  void initState() {
    super.initState();
    getFolders();
    refreshNotes();
  }

  @override
  void dispose() {
    //notesDB.instance.close();
    super.dispose();
  }

  Future getFolders() async {
    allFolders = await folderDB.instance.readAllFolders();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    if(currentFolder.id == null){
      notes = await notesDB.instance.readAllNotes();
    }
    else {
      notes = await notesDB.instance.inFolder(currentFolder.id);
    }
    //print(notes);
    notes = List.from(notes.reversed);
    setState(() {
      isLoading = false;
    });
    //print("notes are ${notes}");
  }

  @override

  Widget build(BuildContext context) {
    refreshNotes();
    getFolders();
    return Material(
      child: _body(folder: currentFolder, notes: notes),
    );
  }

  Future<void> loadNewFolder(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => folder_display(
              folders: allFolders, currentFolder: currentFolder)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    //if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    currentFolder = result;
  }
}

class _body extends StatefulWidget {
  const _body({Key? key, required this.folder, required this.notes}) : super(key: key);
  final Folder folder;
  final notes;

  @override
  State<_body> createState() => _bodyState();
}

class _bodyState extends State<_body> {
  @override


  Widget build(BuildContext context) {
    //print("Notes in body0 are: ${widget.notes}");
    return Scaffold(
      body: Stack(children: [
        NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: false,
              pinned: true,
              expandedHeight: 70,
              collapsedHeight: 50,
              flexibleSpace: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("${currentFolder.name}",
                              style: TextStyle(
                                fontFamily: "euclid-circular-b",
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Center(
                              child: (ispressed== false)
                                  ? (const Icon(
                                      Icons.arrow_drop_up,
                                      size: 30,
                                      color: Colors.grey,
                                    ))
                                  : (const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.grey,
                                    ))),
                        )
                      ],
                    ),
                    onTap: () async {
                      currentFolder = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            ispressed = !ispressed;
                            return folder_display(folders: allFolders, currentFolder: currentFolder);
                          },
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                          )),
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: true);
                      print("Tmp is ${currentFolder.name}");
                    }),
              ),
              automaticallyImplyLeading: true,
              backgroundColor: colors.grey2,
              toolbarHeight: 0,
              elevation: 0,
            ),
          ],
          body: Material(
              child: (!notes.isEmpty)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Expanded(child: staggeredGrid(folder: currentFolder))
                        ],
                      ),
                    )
                  : Container(
                      color: colors.grey2,
                      child: Center(
                        child: Container(
                          child: Text("No Notes",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w300,
                                  color: colors.black0,
                                  fontFamily: "euclid-circular-b")),
                        ),
                      ),
                    )),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: addNoteButton(
              folder: widget.folder,
            ))
      ]),
    );
  }
}

class staggeredGrid extends StatefulWidget {
  staggeredGrid({Key? key, required this.folder}) : super(key: key);
  Folder folder;
  //List<Note> notes;
  @override
  State<staggeredGrid> createState() => _staggeredGridState();
}

class _staggeredGridState extends State<staggeredGrid> {
  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    //print("Notes in staggered grid are: ${notes}");
    return Container(
      color: colors.grey2,
      child: StaggeredGridView.countBuilder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: notes.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
            child: (index % 4 == 1)
                ? longNote(
                    note: notes[index],
                    folder: widget.folder,
                  )
                : (index % 4 == 3)
                    ? wideNote(
                        note: notes[index],
                        folder: widget.folder,
                      )
                    : smallNote(
                        note: notes[index],
                        folder: widget.folder,
                      ),
          );
        },
        staggeredTileBuilder: (index) {
          /*
          return StaggeredTile.count(
              (index % 3 != 1) ? 1 : 1, (index % 3 != 1) ? 1 : 2);

           */
          if (index % 4 == 1) {
            return StaggeredTile.count(1, 2);
          }
          if (index % 4 == 3) {
            return StaggeredTile.count(2, 1);
          } else {
            return StaggeredTile.count(1, 1);
          }
        },
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
      ),
    );
  }
}
