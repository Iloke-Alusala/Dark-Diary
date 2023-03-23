import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/Services/customRectTween.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:diarydark/Pages/note_page.dart';

class addFolderButton extends StatefulWidget {
  const addFolderButton({Key? key}) : super(key: key);

  @override
  State<addFolderButton> createState() => _addFolderButtonState();
}

class _addFolderButtonState extends State<addFolderButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return addFolder();
            }));
            widgetFolderView.refreshFolders();
          });

        },
        child: Hero(
          tag: _heroTag,
          child: Material(
            child: Icon(
              Icons.add,
              size: 70,
              color: colors.white,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: colors.red,
          ),
        ),
      ),
    );
  }
}

const String _heroTag = "heroAddFolder";
final colors = AppColors();

class addFolder extends StatefulWidget {
  addFolder({Key? key}) : super(key: key);

  @override
  State<addFolder> createState() => _addFolderState();
}

class _addFolderState extends State<addFolder> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
        child: Hero(
          tag: _heroTag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.94,
            child: Material(
              color: colors.red,
              elevation: 2,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          style: TextStyle(color: colors.grey1),
                          decoration: InputDecoration(
                              hintText: 'Create Folder',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: colors.grey1)),
                          cursorColor: colors.grey1,
                          controller: textController,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.2,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Folder newFolder = Folder(
                                name: textController.text,
                                creation: DateTime.now(),
                                size: 0);
                            await folderDB.instance.create(newFolder);
                            widgetFolderView.refreshFolders();
                            Navigator.of(context)
                                .pop(HeroDialogRoute(builder: (context) {
                              return folder_view();

                            }));
                          },
                          child: const Text('Create'),
                          style: ElevatedButton.styleFrom(
                              primary: colors.black0,
                              textStyle: TextStyle(color: colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                          minimumSize: Size(20,38)),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
