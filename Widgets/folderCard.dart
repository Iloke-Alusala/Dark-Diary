import 'package:diarydark/Models/Folder.dart';
import 'package:diarydark/Pages/folder_view.dart';
import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/DB/folderDB.dart';
import 'package:intl/intl.dart';

class folderCard extends StatelessWidget {
  folderCard({Key? key, required this.folder, required this.number})
      : super(key: key);

  final Folder folder;
  final int number;
  final heroFolderToOptions = "folderToOptions";
  final colors = AppColors();

  @override
  Widget build(BuildContext context) {
    final dateCreation = DateFormat('d/M/y').format(folder.creation!);
    final timeCreation = DateFormat('jm').format(folder.creation!);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
      child: GestureDetector(
        onTap: () async {
          //await Navigator.of(context).push(customPageRoute(child: note_page()));
        },
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          shadowColor: Colors.white,
          color: colors.black1,
          child: SizedBox(
            //Change Padding around l/r boundaries in folderview
            height: 105,
            width: MediaQuery.of(context).size.width ,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 6, 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  folder.name!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.white,
                                    fontFamily: "euclid-circular-b",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: colors.white,
                                size: 24,
                              )
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3.0, 2, 0,0),
                      child: SizedBox(
                        height: 16,
                        child: Text(
                          "$timeCreation, $dateCreation",
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.grey0,
                            fontFamily: "euclid-circular-b",
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.fromLTRB(3.0, 0, 0,0),
                      child: SizedBox(
                        height: 35,
                        width: 200,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(number.toString(),
                              style: TextStyle(
                                  fontFamily: "euclid-circular-b",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: colors.white)),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class folderOptions extends StatelessWidget {
  const folderOptions({Key? key, required this.folder}) : super(key: key);

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    folderDB.instance.delete(folder.id!);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const folder_view();
                      },
                    ));
                  },
                  child: const Text("Delete")),
            ],
          ),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}

void _showPopupMenu(context, Offset offset) async {
  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(left, top, 0, 0),
    items: [
      const PopupMenuItem(
        value: 3,
        child: Text("Delete"),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

    if (value != null) print(value);
  });
}
