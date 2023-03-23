import 'package:diarydark/Models/Folder.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Widgets/folderCard.dart';
import 'package:diarydark/Services/customRectTween.dart';
import 'package:diarydark/Services/HeroDialogRoute.dart';
import 'package:diarydark/Widgets/addFolderButton.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/DB/notesDB.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:diarydark/Services/customPageRoute.dart';
import 'package:diarydark/Services/SlideupPageRoute.dart';
import 'package:diarydark/Pages/folder_display.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/*
Problem:
 Find a way to refresh page only at certain instances
 */

final widgetFolderView = folder_view.createKey();

class folder_view extends StatefulWidget {
  folder_view({Key? key}) : super(key: key);

  @override
  State<folder_view> createState() => _folder_viewState();

//Create public key to allow access from other classes
  static GlobalKey<_folder_viewState> createKey() =>
      GlobalKey<_folder_viewState>();
}

class _folder_viewState extends State<folder_view> {
  List<Folder> folders = [];

  final Note note = Note(
      isImportant: false,
      number: 0,
      title: '',
      description: '',
      creation: DateTime.now(),
      folderid: 0);

  bool isLoading = false;
  bool ispressed = false;


  Future refreshFolders() async {
    folders = await folderDB.instance.readAllFolders();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshFolders();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    refreshFolders();
    print(folders);
    folderDB.instance.updateSize();
    return Scaffold(
      backgroundColor: colors.black0,
      appBar: AppBar(
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 10, 5),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("folders",
                      style: TextStyle(
                          fontFamily: "euclid-circular-b",
                          fontWeight: FontWeight.w600,
                          fontSize: 35,
                          color: Colors.white)),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onTap: () {
                      ispressed = true;
                      /*
                      Navigator.of(context)
                          .push(SlideupPageRoute(builder: (context) {
                        return folder_display();
                      }));

                       */
                    },
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today_outlined,
                      size: 30, color: Colors.white)
                ],
              ),
            ),
          ),
        ),
        backgroundColor: colors.black0,
        elevation: 0,
      ),
      body: Stack(
        children: [
          (!folders.isEmpty)
              ? buildFolders()
              : Center(
                  child: Text("No Folders",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w300,
                        color: colors.white,
                        fontFamily: "euclid-circular-b",
                      )),
                ),
          Align(alignment: Alignment.bottomRight, child: addFolderButton())
        ],
      ),
    );
    folderDB.instance.close();
    notesDB.instance.close();
  }

  Widget buildFolders() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: folders.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Padding(
            //Change Padding around foldercard border and left+right boundaries
            padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
            child:
                folderCard(folder: folders[index], number: folders[index].size!),
          ),
        );
      },
    );
  }
}

extension refreshFoldersKeyExt on GlobalKey<_folder_viewState> {
  void refreshFolders() => currentState?.refreshFolders();

//String get loginStatus => currentState?.loginStatus ?? 'Signed Out';
}
