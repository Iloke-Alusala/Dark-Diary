import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/DB/folderDB.dart';

final colors = AppColors();

class editFolderName extends StatefulWidget {
  const editFolderName({Key? key, required this.folder}) : super(key: key);

  final folder;

  @override
  State<editFolderName> createState() => _editFolderNameState();
}

class _editFolderNameState extends State<editFolderName> {
  final _fKFolderEditName = GlobalKey<FormState>();
  String originalName = "";

  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textController.text = widget.folder.name;
    originalName = widget.folder.name;
    super.initState();
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
              key: _fKFolderEditName,
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
                                  /*
                                  print(
                                      "Value is : $value and original name is : $originalName");
                                  */
                                  List<String> folderNames = snapshot.data!;
                                  if (value == "") {
                                    return "Please enter a folder name";
                                  }
                                  // This only corrects you if the new name of the folder is not the same as the original
                                  //folder name
                                  if (folderNames.contains(value) == true &&
                                      value != originalName) {
                                    return "Folder name already exists";
                                  }
                                  return null;
                                },
                                style: TextStyle(color: colors.grey1),
                                decoration: InputDecoration(
                                    hintText: 'Change Folder',
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
                            // important piece
                            if (_fKFolderEditName.currentState!.validate()) {
                              Folder newFolder =
                                  widget.folder.copy(name: textController.text);
                              await folderDB.instance.update(newFolder);
                              widgetFolderView.refreshFolders();
                              /* changing
                               Navigator.of(context)
                               .pop(HeroDialogRoute(builder: (context) {
                                                             //return folder_view();
                                                           }));
                              to
                               Navigator.of(context)
                                                             .pop(); makes it upload files proper

                               */
                              Navigator.of(context).pop();
                              Navigator.pop(context, newFolder);
                            }
                          },
                          child: const Text('Change'),
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
