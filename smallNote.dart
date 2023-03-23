import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Pages/note_view.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Services/customPageRoute.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/Services/customRectTween.dart';

class smallNote extends StatelessWidget {
  smallNote({Key? key, required this.note, required this.folder})
      : super(key: key);
  final colors = AppColors();
  final Note note;
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(customPageRoute(child:
        note_view(note: note, folder: folder, isNewNote: false)));
      },
      /*
      onLongPress: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return deleteNoteTemp(note: note);
        }));
      },
       */
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: colors.grey1,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 11, 10, 2),
              child: Container(
                child: Text(
                  note.title!,
                  style: TextStyle(
                      fontFamily: "euclid-circular-b",
                      color: colors.black0,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                color: colors.grey0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: (note.description!.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                      child: Center(
                        child: Container(
                          child: Text(
                            "Waiting for a message",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "euclid-circular-b",
                              color: colors.grey0,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        note.description!,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "euclid-circular-b",
                          color: colors.grey0,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 5,
                      ),
                    ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton(
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: Text('Delete'), onTap: () async{
                                      await notesDB.instance.delete(note.id);
                                      widgetFolderView.refreshFolders();
                                      folderDB.instance.updateSize();
                                },
                                ),
                              ])
                    ],
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
/*
final heroTag = "deleteNote";

class deleteNoteTemp extends StatelessWidget {
  deleteNoteTemp({Key? key, required this.note}) : super(key: key);
  final Note note;
  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Hero(
          tag: heroTag,
          child: Text(
            "Delete",
            style: TextStyle(
                color: colors.grey0,
                fontFamily: "euclid-circular-b",
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
 */
