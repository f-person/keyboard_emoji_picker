import 'dart:async';

import 'package:flutter/services.dart';

export 'src/keyboard_emoji_picker_wrapper.dart';

class KeyboardEmojiPickerController {
  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('keyboard_emoji_picker');

  static Future<String?> pickEmoji() async {
    final completer = Completer<String?>();

    _methodChannel.invokeMethod('pickEmoji');
    _methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'emojiPicked':
          return completer.complete(call.arguments['emoji']);
        case 'emojiPickerClosed':
          return completer.complete(null);
        case 'openingKeyboardFailed':
          final failure = call.arguments['failure'];
          if (failure == 'noEmojiKeyboard') {
            return completer.completeError(const NoEmojiKeyboardFound());
          } else {
            return completer.completeError(const UnknownError());
          }
      }
    });

    return completer.future;
  }

  static Future<bool> checkHasEmojiKeyboard() async {
    final result = await _methodChannel.invokeMethod<bool>('hasEmojiKeyboard');
    return result ?? false;
  }

  static void closeEmojiKeyboard() {
    _methodChannel.invokeMethod('closeEmojiKeyboard');
  }
}

class NoEmojiKeyboardFound implements Exception {
  const NoEmojiKeyboardFound();

  @override
  String toString() {
    return 'No emoji keyboard found';
  }
}

class UnknownError implements Exception {
  const UnknownError();

  @override
  String toString() {
    return 'Unknown error';
  }
}
