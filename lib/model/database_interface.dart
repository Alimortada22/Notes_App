
import 'package:notes_app/model/note.dart';

abstract class DataBase {
  void createNewNotea(Note note);
  void loadData() ;
  void updateNote(int index,String text,String subText);
  void deleteNote(int index);
}
