import 'package:flutter/material.dart';
import 'package:diarydark/Colors/Colors.dart';
import 'package:diarydark/Models/Folder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class panelWidget extends StatelessWidget {
  panelWidget({Key? key, required this.panelController}) : super(key: key);

  PanelController panelController;
  final colors = AppColors();
  List<Folder> folders = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: Container(
          height: MediaQuery.of(context).size.height*0.7,

        )
      );
  }
}
