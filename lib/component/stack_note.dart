import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/model/note_database.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StackNote extends StatelessWidget {
   StackNote({super.key,required this.currentnotes,required this.index});
List<Note> currentnotes;
int index;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () =>
                              context.read<NoteDatabase>().deleteNote(index),
                          icon: const Icon(Icons.delete))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentnotes[index].subTitle!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(currentnotes[index].noteText!)
                    ],
                  ),
                ]);
  }
}