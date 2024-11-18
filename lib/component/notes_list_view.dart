import 'package:flutter/material.dart';
import 'package:notes_app/component/stack_note.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/pages/dispaly_note.dart';
import 'package:notes_app/pages/update_page.dart';

// ignore: must_be_immutable
class NotesListView extends StatelessWidget {
  NotesListView(
      {super.key,
      required this.currentnotes,
      required this.textcontroller,
      required this.textsubtitlecontroller,
      required this.uppdatednote});
  List<Note> currentnotes;
  TextEditingController textcontroller;
  TextEditingController textsubtitlecontroller;
  void Function(int index) uppdatednote;
  void onTap(int index, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayNote(displayNote: currentnotes[index]),
        ));
  }

  void onLongPress(int index, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePage(
                note: currentnotes[index],
                notebodycontroller: textcontroller,
                onTap: () => uppdatednote(index),
                subtitlecontroller: textsubtitlecontroller)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: currentnotes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => onTap(index, context),
              onLongPress: () => onLongPress(index, context),
              child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100]),
                  child: StackNote(currentnotes: currentnotes, index: index)));
        });
  }
}
