import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

// ignore: must_be_immutable
class CreateNotePage extends StatefulWidget {
  CreateNotePage(
      {super.key,
      required this.onTap,
      required this.notebodycontroller,
      required this.subtitlecontroller});
  void Function()? onTap;
  TextEditingController subtitlecontroller;
  TextEditingController notebodycontroller;

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void startListing() async {
    await _speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void onSpeechResult(result) {
    setState(() {
      widget.notebodycontroller.text = '${result.recognizedWords}';
    });
  }

  void stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[100],
          onPressed: () =>
              _speechToText.isListening ? stopListening() : startListing(),
              tooltip: "Listening",
          child: _speechToText.isListening
              ? const Icon(Icons.mic,color: Colors.black,)
              : const Icon(
                  Icons.mic_off,color: Colors.black
                )),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: widget.onTap, icon: const Icon(Icons.done)),
          IconButton(
              onPressed: () {
Navigator.pop(context);
widget.subtitlecontroller.clear();
widget.notebodycontroller.clear();

              } ,
              icon: const Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: widget.subtitlecontroller,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "Sub Title",
                  border: InputBorder.none),
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: widget.notebodycontroller,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: "Write some Notes...!",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
