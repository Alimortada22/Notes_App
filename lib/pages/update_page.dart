import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';

// ignore: must_be_immutable
class UpdatePage extends StatelessWidget {
  UpdatePage(
      {super.key,
      required this.note,
      required this.notebodycontroller,
      required this.onTap,
      required this.subtitlecontroller});
  Note note;
  void Function()? onTap;
  TextEditingController subtitlecontroller;
  TextEditingController notebodycontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: onTap, icon: const Icon(Icons.done)),
          IconButton(
              onPressed: ()  {Navigator.pop(context);
              subtitlecontroller.clear();
              notebodycontroller.clear();
              },
              icon: const Icon(Icons.close))
        ],
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: subtitlecontroller..text = note.subTitle!,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            const Divider(
              color:  Colors.black,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: notebodycontroller..text = note.noteText!,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
