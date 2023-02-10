import 'dart:async';

import 'package:flutter/services.dart';

export 'src/keyboard_emoji_picker_wrapper.dart';

class KeyboardEmojiPickerController {
  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('keyboard_emoji_picker');

  static Future<String> pickEmoji() async {
    final completer = Completer<String>();

    _methodChannel.invokeMethod('pickEmoji');
    _methodChannel.setMethodCallHandler((call) async {
      final didPickEmoji = call.method == 'emojiPicked';
      if (didPickEmoji) {
        completer.complete(call.arguments['emoji']);
      }

      final isFailure = call.method == 'openingKeyboardFailed';
      if (isFailure) {
        final failure = call.arguments['failure'];
        if (failure == 'noEmojiKeyboard') {
          completer.completeError(const NoEmojiKeyboardFound());
        } else {
          completer.completeError(const UnknownError());
        }
      }
    });

    return completer.future;
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
