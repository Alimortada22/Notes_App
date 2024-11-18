import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/model/note_database.dart';
import 'package:notes_app/pages/note_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //inint hive
  await Hive.initFlutter();
  //open a box
Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('mybox');
  runApp(ChangeNotifierProvider(

    create: (context) => NoteDatabase(),
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  NotePage(),
    );
  }
}
