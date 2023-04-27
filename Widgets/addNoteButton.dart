import 'package:flutter/material.dart';
import 'package:diarydark/Pages/note_view.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Services/customPageRoute.dart';

class addNoteButton extends StatelessWidget {
  addNoteButton({Key? key, required this.folder}) : super(key: key);

  final Folder folder;
  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    // Create empty note template
    final Note emptyNote = Note(
        title: "",
        isImportant: false,
        description: "",
        creation: DateTime.now(),
        number: 0,
        folderid: folder.id);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(customPageRoute(
              child:
                  note_view(note: emptyNote, folder: folder, isNewNote: true)));
        },
        child: Material(
          child: Icon(
            Icons.add,
            size: 70,
            color: colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: colors.red,
          elevation: 10,
        ),
      ),
    );
  }
}
