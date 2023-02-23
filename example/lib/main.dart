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
  final _pickEmojiResults = <String?>[];

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
            // You can have it anywhere you want.
            const KeyboardEmojiPickerWrapper(child: SizedBox.shrink()),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 84),
              child: Center(
                child: Text(
                  _selectedEmoji ??
                      'No emoji selected yet.\nPress the button below to pick one!',
                  style: TextStyle(
                    fontSize: _selectedEmoji == null ? 16 : 64,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final emoji = await KeyboardEmojiPicker().pickEmoji();

                setState(() {
                  _pickEmojiResults.insert(0, emoji);
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
            const Text('pickEmoji results:'),
            Expanded(
              child: ListView.builder(
                itemCount: _pickEmojiResults.length,
                itemBuilder: (context, index) {
                  final result = _pickEmojiResults[index];

                  return Text(
                    result.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40),
                  );
                },
              ),
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
