import 'package:diarydark/DB/notesDB.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/Widgets/addFolderButton.dart';
import 'package:diarydark/Widgets/editFolderName.dart';

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
Folder allNotes = Folder(name: "All notes", creation: DateTime.now(), size: 0);
//for Modularity, with an id of -1000000, all uncategorised notes will appear in note_page
Folder noCatFolder = Folder(name: "No category", creation: DateTime.now(),size: 0, id: -1000000);
int notesSize = 0;
bool manageActive = false;

class _folder_displayState extends State<folder_display> {
  @override
  void initState() {
    super.initState();
    manageActive = false;
  }

  Future<int> getAllNoteSizes() async {
    return await notesDB.instance.allNotesSize();
  }

  @override
  Widget build(BuildContext context) {
    folderDB.instance.updateSize();
    return Material(
      color: colors.black2,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      child: SizedBox(
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
                      // Can only go to All Notes page if you aren't in manage mode
                      (!manageActive) ? Navigator.pop(context, allNotes) : null;
                    },
                    child: ListTile(
                      leading: Icon(Icons.edit_note_outlined,
                          color: (!manageActive) ? colors.white : colors.grey1,
                          size: 25),
                      title: Text("All notes",
                          style: TextStyle(
                            color:
                                (!manageActive) ? colors.white : colors.grey1,
                            fontSize: 18,
                            fontFamily: "euclid-circular-b",
                          )),
                      trailing: FutureBuilder<int>(
                        future: getAllNoteSizes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text("${snapshot.data}",
                                style: TextStyle(
                                  color: (!manageActive)
                                      ? colors.white
                                      : colors.grey1,
                                  fontSize: 18,
                                  fontFamily: "euclid-circular-b",
                                ));
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_outlined,
                        color: (!manageActive) ? colors.white : colors.grey1,
                        size: 25),
                    title: Text("No category",
                        style: TextStyle(
                          // manage mode
                          color: (!manageActive) ? colors.white : colors.grey1,
                          fontSize: 18,
                          fontFamily: "euclid-circular-b",
                        )),
                    trailing: FutureBuilder<String>(
                      future: notesDB.instance.getUncategorisedNotesCount(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!,
                              style: TextStyle(
                                fontFamily: "euclid-circular-b",
                                fontSize: 18,
                                // manage mode
                                color: (!manageActive)
                                    ? colors.white
                                    : colors.grey1,
                                decoration: TextDecoration.none,
                              ));
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    onTap: (){
                      (!manageActive) ? Navigator.pop(context, noCatFolder) : null;
                    },
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
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 5),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        manageActive = !manageActive;
                      });
                    },
                    child: Text(
                      // if the MANAGE button has been pressed, change the text of it
                      (!manageActive) ? "MANAGE" : "COMPLETED",
                      style: TextStyle(
                        color: colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "euclid-circular-b",
                      ),
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
                // When the Manage button has not been clicked, then build the normal listview
                child: (!manageActive)
                    ? ListView.builder(
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    // manage mode
                                    color: (!manageActive)
                                        ? colors.white
                                        : colors.grey1),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                        // if the Manage Button has been pressed, then build the editable listview
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              (!manageActive)
                                  ? () {
                                      widget.currentFolder =
                                          widget.folders[index];
                                      Navigator.pop(
                                          context, widget.currentFolder);
                                    }
                                  : null;
                            },
                            leading: Icon(Icons.folder_open,
                                color: (!manageActive)
                                    ? colors.white
                                    : colors.grey1,
                                size: 22),
                            title: Text(
                              widget.folders[index].name,
                              style: TextStyle(
                                  fontFamily: "euclid-circular-b",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: (!manageActive)
                                      ? colors.white
                                      : colors.grey1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: colors.white,
                                    size: 23,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        HeroDialogRoute(
                                            builder: (context) =>
                                                editFolderName(
                                                    folder: widget
                                                        .folders[index])));

                                  },
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: colors.white,
                                    size: 23,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          HeroDialogRoute(
                                              builder: (context) => confirmFileDelete(folder: widget.folders[index])));
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        }),
                        itemCount: widget.folders.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // if the Manage Button has been pressed, then build the editable listview
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      HeroDialogRoute(builder: (context) => const addFolder()));
                },
                child: ListTile(
                    leading: Icon(Icons.add, size: 25, color: colors.white),
                    title: Text(
                      "New Folder",
                      style: TextStyle(
                          color: colors.white,
                          fontFamily: "euclid-circular-b",
                          fontWeight: FontWeight.w600),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class confirmFileDelete extends StatefulWidget {
  const confirmFileDelete({Key? key, required this.folder}) : super(key: key);

  final folder;

  @override
  State<confirmFileDelete> createState() => _confirmFileDeleteState();
}

void updateFolderList(Folder folder) async {
  await folderDB.instance.delete(folder.id);
}

class _confirmFileDeleteState extends State<confirmFileDelete> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colors.black2,
      title: Text(
        'Delete folder "${widget.folder.name}" and its contents?',
        style: TextStyle(
          color: colors.grey2,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          fontFamily: "euclid-circular-b",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: colors.grey2,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: "euclid-circular-b",
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            updateFolderList(widget.folder);
            setState(() {
              Navigator.of(context).pop();
              Navigator.pop(context, allNotes);
              //print("popped delete page");
            });
          },
          child: Text(
            'Delete',
            style: TextStyle(
              color: colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: "euclid-circular-b",
            ),
          ),
        ),
      ],
    );
  }
}
