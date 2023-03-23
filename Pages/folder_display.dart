import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Widgets/wideNote.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Pages/note_page.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/Widgets/addFolderButton.dart';

class folder_display extends StatefulWidget {
  folder_display({Key? key, required this.folders, required this.currentFolder})
      : super(key: key);

  @override
  State<folder_display> createState() => _folder_displayState();
  final folders;
  Folder currentFolder;
}

final colors = AppColors();
int allNotesSize = 0;

const String _heroTag = "heroAddFolder";
Folder allNotes = Folder(name: "All Notes", creation: DateTime.now(), size: 0);
int notesSize = 0;

class _folder_displayState extends State<folder_display> {
  @override
  void initState() {
    super.initState();
  }

  Future<int> getAllNoteSizes() async {
    return await notesDB.instance.allNotesSize();
  }

  @override
  Widget build(BuildContext context) {
    folderDB.instance.updateSize();
    return Material(
      color: colors.black2,
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.68,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Notes",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: colors.white,
                        fontFamily: "euclid-circular-b",
                      )),
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: colors.grey0,
                      size: 32,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, allNotes);
                    },
                    child: ListTile(
                      leading: Icon(Icons.edit_note_outlined,
                          color: colors.white, size: 25),
                      title: Text("All notes",
                          style: TextStyle(
                            color: colors.white,
                            fontSize: 18,
                            fontFamily: "euclid-circular-b",
                          )),
                      trailing: FutureBuilder<int>(
                        future: getAllNoteSizes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("${snapshot.data}",
                                style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "euclid-circular-b",
                                ));
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_outlined,
                        color: colors.white, size: 25),
                    title: Text("No category",
                        style: TextStyle(
                          color: colors.white,
                          fontSize: 18,
                          fontFamily: "euclid-circular-b",
                        )),
                    trailing: Text("80",
                        style: TextStyle(
                          fontFamily: "euclid-circular-b",
                          fontSize: 18,
                          color: colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Divider(
                color: colors.grey1,
                height: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Folder",
                    style: TextStyle(
                        fontFamily: "euclid-circular-b",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: colors.grey1),
                  ),
                  Text(
                    "MANAGE",
                    style: TextStyle(
                      color: colors.grey1,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "euclid-circular-b",
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              //Create the list of all the folder names
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      child: ListTile(
                        leading: Icon(Icons.folder_open,
                            color: colors.white, size: 22),
                        title: Text(
                          widget.folders[index].name,
                          style: TextStyle(
                              fontFamily: "euclid-circular-b",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: colors.grey1),
                        ),
                        trailing: Text("${widget.folders[index].size}",
                            style: TextStyle(
                                fontFamily: "euclid-circular-b",
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: colors.grey1)),
                      ),
                      onTap: () {
                        widget.currentFolder = widget.folders[index];
                        Navigator.pop(context, widget.currentFolder);
                      },
                    );
                  }),
                  itemCount: widget.folders.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(HeroDialogRoute(builder: (context) {
                    return addFolder();
                  }));
                },
                child: Hero(
                  tag: _heroTag,
                  child: ListTile(
                      leading: Icon(Icons.add, size: 25, color: colors.white),
                      title: Text(
                        "New Folder",
                        style: TextStyle(
                            color: colors.white,
                            fontFamily: "euclid-circular-b"),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
