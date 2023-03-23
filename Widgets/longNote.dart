import 'package:diarydark/DB/folderDB.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Pages/note_view.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Services/customPageRoute.dart';

class longNote extends StatelessWidget {
  longNote({Key? key, required this.note, required this.folder})
      : super(key: key);
  final colors = AppColors();
  final Note? note;
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(customPageRoute(
            child: note_view(
          note: note,
          folder: folder,
          isNewNote: false,
        )));
      },
      child: Container(
        width: 180,
        height: 880,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: colors.black0,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // pre: fromLTRB(10,16,10,10)
              padding: const EdgeInsets.fromLTRB(10, 11, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.54,
                    child: Text(
                      note!.title!,
                      style: TextStyle(
                          fontFamily: "euclid-circular-b",
                          color: colors.white,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 11),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                  PopupMenuButton(
                      icon: Container(
                        height: 15,
                        width: 15,
                        child: Image.asset("lib/Icons/kebab.png"),
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Delete'),
                              onTap: () async {
                                await notesDB.instance.delete(note!.id);
                                widgetFolderView.refreshFolders();
                                folderDB.instance.updateSize();
                              },
                            ),
                          ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                color: colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: (note!.description!.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 130, 0, 0),
                      child: Center(
                        child: Text(
                          "Waiting for a message",
                          style: TextStyle(
                              fontFamily: "euclid-circular-b",
                              color: colors.grey0,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12),
                          textAlign: TextAlign.start,
                          maxLines: 5,
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        note!.description!,
                        style: TextStyle(
                            fontFamily: "euclid-circular-b",
                            color: colors.grey0,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12),
                        textAlign: TextAlign.start,
                        maxLines: 19,
                      ),
                    ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
