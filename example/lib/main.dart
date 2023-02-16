import 'package:flutter/material.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedEmoji;
  bool _hasKeyboard = false;

  @override
  void initState() {
    super.initState();
    _checkHasEmojiKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Emoji Picker Example'),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              _selectedEmoji ??
                  'No emoji selected yet.\nPress the button below to pick one!',
              style: TextStyle(
                fontSize: _selectedEmoji == null ? 16 : 64,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () async {
                KeyboardEmojiPicker().pickEmoji();
                final emoji = await KeyboardEmojiPicker().pickEmoji();
                print('Picked emoji: $emoji');
                setState(() {
                  if (emoji != null) {
                    _selectedEmoji = emoji;
                  }
                });
              },
              child: const Text('Pick an emoji from the keyboard!'),
            ),
            TextButton(
              onPressed: KeyboardEmojiPicker().closeEmojiKeyboard,
              child: const Text('Close'),
            ),
            const SizedBox(height: 16),
            Text('Has emoji keyboard: $_hasKeyboard'),
            const KeyboardEmojiPickerWrapper(
              child: SizedBox(),
            ),
          ]),
        ),
      ),
    );
  }

  void _checkHasEmojiKeyboard() async {
    final hasKeyboard = await KeyboardEmojiPicker().checkHasEmojiKeyboard();
    setState(() {
      _hasKeyboard = hasKeyboard;
    });
  }
}
