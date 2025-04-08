import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// ignore: must_be_immutable
class CreateNotePage extends StatefulWidget {
  CreateNotePage(
      {super.key,
      required this.onTap,
      required this.notebodycontroller,
      required this.subtitlecontroller});
  void Function(TextDirection textdir)? onTap;
  TextEditingController subtitlecontroller;
  TextEditingController notebodycontroller;

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final SpeechToText _speech = SpeechToText();
  String _selectedLocale = 'en-US';
  List<LocaleName> _availableLocales = [];
  String _recognizedText = 'Press the mic button to start';
  bool _isListening = false;
  bool isArabic = false;
  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  void initSpeech() async {
    try {
      var hasPermission = await _speech.initialize(
        onStatus: _statusListener,
        onError: _errorListener,
        debugLogging: true,
      );

      if (hasPermission) {
        _availableLocales = await _speech.locales();
        // Check if our required locales are available
        final hasEnglish = _availableLocales.any((l) => l.localeId == 'en-US');
        final hasArabic = _availableLocales.any((l) => l.localeId == 'ar-EG');

        if (!hasEnglish || !hasArabic) {
          _recognizedText = 'Some languages not supported on this device';
        }
      } else {
        _recognizedText = 'Speech recognition permission denied';
      }
    } catch (e) {
      _recognizedText = 'Error initializing speech: $e';
    }
    if (mounted) setState(() {});
  }

  void _statusListener(String status) {
    if (status == 'done' && _isListening) {
      _stopListening();
    }
  }

  void _errorListener(SpeechRecognitionError error) {
    setState(() {
      _recognizedText = 'Error: ${error.errorMsg}';
      _isListening = false;
    });
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      _stopListening();
    } else {
      await _startListening();
    }
  }

  Future<void> _startListening() async {
    try {
      setState(() {
        _isListening = true;
        _recognizedText =
            _selectedLocale.startsWith('ar') ? 'استمع...' : 'Listening...';
      });

      await _speech.listen(
        onResult: _onSpeechResult,
        localeId: _selectedLocale,
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
            partialResults: true, ),
    
      );
    } catch (e) {
      setState(() {
        _isListening = false;
        _recognizedText = 'Error: $e';
      });
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
      widget.notebodycontroller.text =_recognizedText;
    });
  }

  void _changeLanguage(String newLocale) {
    setState(() {
      _selectedLocale = newLocale;
      newLocale.startsWith('ar') ? isArabic = true : isArabic = false;
    });
    if (_isListening) {
      _stopListening();
      _startListening();
    }
  }

  void onSpeechResult(result) {
    setState(() {
      widget.notebodycontroller.text = '${result.recognizedWords}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isListening ? Colors.red : Colors.blue,
        onPressed: _toggleListening,
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            isArabic?widget.onTap!(TextDirection.rtl):widget.onTap!(TextDirection.ltr);
          }, icon: const Icon(Icons.done)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                widget.subtitlecontroller.clear();
                widget.notebodycontroller.clear();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: DropdownButton<String>(
                value: _selectedLocale,
                items: const [
                  DropdownMenuItem(
                    value: 'en-US',
                    child: Text('English (US)'),
                  ),
                  DropdownMenuItem(
                    value: 'ar-EG',
                    child: Text('العربية (مصر)'),
                  ),
                ],
                onChanged: (value) => _changeLanguage(value!),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              textDirection:isArabic?TextDirection.rtl:TextDirection.ltr ,
              controller: widget.subtitlecontroller,
              decoration:  InputDecoration(
                  hintStyle:const  TextStyle(color: Colors.black),hintTextDirection:isArabic?TextDirection.rtl:TextDirection.ltr ,
                  hintText: isArabic?"العنوان":"Sub Title",
                  border: InputBorder.none),
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: TextField(
                
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                controller: widget.notebodycontroller,
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black),hintTextDirection:isArabic?TextDirection.rtl:TextDirection.ltr ,
                    hintText:
                        _isListening ? _recognizedText :isArabic?"ابدا في الكتابه ...":"Write some Notes...!",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
