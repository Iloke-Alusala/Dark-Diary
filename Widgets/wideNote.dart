import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Pages/note_view.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Services/customPageRoute.dart';
import 'package:diarydark/DB/folderDB.dart';

class wideNote extends StatelessWidget {
  wideNote({Key? key, required this.note, required this.folder})
      : super(key: key);
  final colors = AppColors();
  final Note? note;
  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(customPageRoute(child: note_view(
                  note: note,
                  folder: folder,
                  isNewNote: false,
                )));
      },
      child: Container(
        //Height and width don't matter because it is part of a pre-designed grid
        width: 180,
        height: 190,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: colors.grey1,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 2, 0),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                        note!.title!,
                        style: TextStyle(
                          fontFamily: "euclid-circular-b",
                          color: colors.black0,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: const Text('Delete'), onTap: () async{
                                await notesDB.instance.delete(note!.id);
                                widgetFolderView.refreshFolders();
                                folderDB.instance.updateSize();
                              },),
                            ],
                    iconSize: 26,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,0),
              child: Divider(
                color: colors.grey0,
              ),
            ),
            //Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: (note!.description!.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: Center(
                        child: Text(
                          "Waiting for a message",
                          style: TextStyle(
                            fontFamily: "euclid-circular-b",
                            color: colors.grey0,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 5,
                        ),
                      ),
                    )
                  : Text(
                    note!.description!,
                    style: TextStyle(
                      fontFamily: "euclid-circular-b",
                      color: colors.grey0,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
