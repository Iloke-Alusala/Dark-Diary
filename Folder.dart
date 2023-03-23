import 'package:flutter/cupertino.dart';

final String tableFolder = "folder";

class FolderFields {
  static final List<String> values = [
    ///Add all fields
    id, name, time, size
  ];

  static final String id = '_id';
  static final String name = 'isImportant';
  static final String time = "creation";
  static final String size = "size";
}

class Folder {
  final int? id;
  final String? name;
  final DateTime? creation;
  final int? size;

  const Folder({
    this.id,
    required this.name,
    required this.creation,
    required this.size,
  });

  Folder copy({
    int? id,
    String? name,
    DateTime? createdTime,
    int? size,
  }) =>
      Folder(
        id: id ?? this.id,
        name: name ?? this.name,
        creation: createdTime ?? this.creation,
        size: size ?? this.size,
      );

  static Folder fromJson(Map<String, Object?> json) => Folder(
    id: json[FolderFields.id] as int?,
    name: json[FolderFields.name] as String,
    creation: DateTime.parse(json[FolderFields.time] as String),
    size: json[FolderFields.size] as int,
  );

  Map<String, Object?> toJson() => {
    FolderFields.id: id,
    FolderFields.name: name,
    FolderFields.time: creation!.toIso8601String(),
    FolderFields.size: size,
  };
}
