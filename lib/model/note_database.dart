import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:notes_app/model/database_interface.dart';
import 'package:notes_app/model/note.dart';

class NoteDatabase extends ChangeNotifier implements DataBase {
  final _box = Hive.box('mybox');

  List<Note> currentnotes = [Note( noteText: "sFGDFG",subTitle: "sfsfds")];

  @override
  void createNewNotea(Note newNote)  {

    currentnotes.add(newNote);

    _box.put("NoteListss", currentnotes);

    notifyListeners();
    loadData();
  }

  @override
  void loadData() {
    List ll= _box.get("NoteListss")??[];
    currentnotes=[...ll];
    
  }

  @override
  void updateNote(int index, String notetext,String subText) {
    currentnotes[index].noteText = notetext;
    currentnotes[index].subTitle=subText;
    _box.put("NoteListss", currentnotes);
    notifyListeners();
    loadData();
  }

  @override
  void deleteNote(int index) {
    currentnotes.removeAt(index);
    _box.put("NoteListss", currentnotes);
    notifyListeners();
    loadData();
  }
}
