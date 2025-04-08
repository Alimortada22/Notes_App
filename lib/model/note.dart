import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? subTitle;
  @HiveField(1)
  String? noteText;
    @HiveField(2)
  TextDirection? notetextdir;
  Note({this.subTitle, this.noteText,this.notetextdir});
}
