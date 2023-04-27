import 'package:diarydark/Models/Folder.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Widgets/folderCard.dart';
import 'package:diarydark/Widgets/addFolderButton.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:diarydark/Models/Note.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
/*
Problem:
 Find a way to refresh page only at certain instances
 */
// This will create the reference that will allow you to access methods in other files
final widgetFolderView = folder_view.createKey();

class folder_view extends StatefulWidget {
  const folder_view({Key? key}) : super(key: key);

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
  bool isPressed = false;


  Future refreshFolders() async {
    folders = await folderDB.instance.readAllFolders();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshFolders();
  }

  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    refreshFolders();
    //print(folders);
    folderDB.instance.updateSize();
    return Scaffold(
      backgroundColor: colors.black0,
      appBar: AppBar(
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 10, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("folders",
                    style: TextStyle(
                        fontFamily: "euclid-circular-b",
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                        color: Colors.white)),
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onTap: () {
                    isPressed = true;
                    /*
                    Navigator.of(context)
                        .push(SlideupPageRoute(builder: (context) {
                      return folder_display();
                    }));

                     */
                  },
                ),
                const Spacer(),
                const Icon(Icons.calendar_today_outlined,
                    size: 30, color: Colors.white)
              ],
            ),
          ),
        ),
        backgroundColor: colors.black0,
        elevation: 0,
      ),
      body: Stack(
        children: [
          (folders.isNotEmpty)
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
          const Align(alignment: Alignment.bottomRight, child: addFolderButton())
        ],
      ),
    );
  }

  Widget buildFolders() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 1,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: folders.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Padding(
            //Change Padding around foldercard border and left+right boundaries
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
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
