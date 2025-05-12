// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'note.g.dart';

class Task {
  final String id;
  final String title;
  final String desc;
  final bool isUploaded;

  Task({
    required this.id,
    required this.title,
    required this.desc,
    this.isUploaded = false,
  });
}

@HiveType(typeId: 0) // Unique ID for this object type
class Note {
  @HiveField(0) // MUST start from 0
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final bool isUploaded;

  Note({
    this.id = 1,
    required this.title,
    required this.desc,
    this.isUploaded = false,
  });

  Note copyWith({int? id, String? title, String? desc, bool? isUploaded}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }
}
