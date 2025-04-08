import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({required this.displayNote, super.key});
  final Note displayNote;
  @override
  Widget build(BuildContext context) {
    print(displayNote.notetextdir);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close))
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: displayNote.notetextdir==TextDirection.rtl?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(
              displayNote.subTitle!,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              displayNote.noteText!,
              style: const TextStyle(fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}
