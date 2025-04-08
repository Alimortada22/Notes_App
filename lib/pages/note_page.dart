import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:notes_app/component/notes_list_view.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/model/note_database.dart';
import 'package:notes_app/pages/create_note_page.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final textcontroller = TextEditingController();
  final textsubtitlecontroller = TextEditingController();

  void newCreateNote(TextDirection textdir) {
    if (textcontroller.text.isNotEmpty &&
        textsubtitlecontroller.text.isNotEmpty) {
      context.read<NoteDatabase>().createNewNotea(Note(
        notetextdir: textdir,
          subTitle: textsubtitlecontroller.text,
          noteText: textcontroller.text));
      textcontroller.clear();
      textsubtitlecontroller.clear();
      Navigator.pop(context);
    }else{
      showToast('Missing Requierd field',
   context: context,
   animation: StyledToastAnimation.scale,
   reverseAnimation: StyledToastAnimation.fade,
   position: StyledToastPosition.center,
   animDuration:const Duration(seconds: 1),
   duration: const Duration(seconds: 4),
   curve: Curves.elasticOut,
   reverseCurve: Curves.linear,
);
    }
  }

  void readNotes() {
    context.read<NoteDatabase>().loadData();
  }

  void uppdatednote(int index) {
    if (textcontroller.text.isNotEmpty &&
        textsubtitlecontroller.text.isNotEmpty) {
      context
          .read<NoteDatabase>()
          .updateNote(index, textcontroller.text, textsubtitlecontroller.text);
      textcontroller.clear();
      textsubtitlecontroller.clear();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notedatabase = context.watch<NoteDatabase>();
    List<Note> currentnotes = notedatabase.currentnotes;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            "Notes",
            style: TextStyle(fontSize: 32),
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[100],
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateNotePage(
                      onTap: newCreateNote,
                      notebodycontroller: textcontroller,
                      subtitlecontroller: textsubtitlecontroller))),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: NotesListView(
            currentnotes: currentnotes,
            textcontroller: textcontroller,
            textsubtitlecontroller: textsubtitlecontroller,
            uppdatednote: uppdatednote));
  }
}
