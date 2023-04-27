import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/DB/folderDB.dart';

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
              return const addFolder();
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
  const addFolder({Key? key}) : super(key: key);

  @override
  State<addFolder> createState() => _addFolderState();
}

class _addFolderState extends State<addFolder> {
  final textController = TextEditingController();

  final _fKFolderName = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<List<String?>> names() async {
    var result = await folderDB.instance.getFoldersNames();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.94,
          child: Material(
            color: colors.red,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Form(
              key: _fKFolderName,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder<List<String>>(
                          future: folderDB.instance.getFoldersNames(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return TextFormField(
                                validator: (value) {
                                  List<String> folderNames = snapshot.data!;
                                  if (value == "") {
                                    return "Please enter a folder name";
                                  }
                                  if (folderNames.contains(value) == true) {
                                    return "Folder name already exists";
                                  }
                                  return null;
                                },
                                style: TextStyle(color: colors.grey1),
                                decoration: InputDecoration(
                                    hintText: 'Create Folder',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: colors.grey1),
                                    errorStyle: TextStyle(color: colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colors.grey0)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colors.white)),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colors.grey2)),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colors.grey2))),
                                cursorColor: colors.grey1,
                                controller: textController,
                              );
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_fKFolderName.currentState!.validate()) {
                              Folder newFolder = Folder(
                                  name: textController.text,
                                  creation: DateTime.now(),
                                  size: 0);
                              await folderDB.instance.create(newFolder);
                              widgetFolderView.refreshFolders();
                              // changing this to
                              // Navigator.of(context)
                              // .pop(HeroDialogRoute(builder: (context) {
                              //                               //return folder_view();
                              //                             }));
                              // Navigator.of(context)
                              //                                 .pop(); makes it upload files proper
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Create'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colors.black0,
                              textStyle: TextStyle(color: colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(20, 38)),
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
