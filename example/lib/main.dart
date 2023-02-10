import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
  final _keyboardEmojiPickerPlugin = KeyboardEmojiPickerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            TextButton(
              onPressed: () async {
                final emoji = await _keyboardEmojiPickerPlugin.pickEmoji();
                print('picked emoji: $emoji');
              },
              child: const Text('Open'),
            ),
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              child: const Text('Close'),
            ),
            const KeyboardEmojiPickerWrapper(
              child: SizedBox(),
            ),
          ]),
        ),
      ),
    );
  }
}
