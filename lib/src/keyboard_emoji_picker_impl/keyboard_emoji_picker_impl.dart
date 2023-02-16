import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker.dart';
import 'package:keyboard_emoji_picker/src/keyboard_emoji_picker_impl/method_call_name.dart';

class KeyboardEmojiPickerImpl implements KeyboardEmojiPicker {
  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('keyboard_emoji_picker');

  @override
  Future<String?> pickEmoji() async {
    final completer = Completer<String?>();

    _methodChannel.setMethodCallHandler(_createMethodCallHandler(completer));
    _methodChannel.invokeMethod('pickEmoji');

    final result = await completer.future;

    _methodChannel.setMethodCallHandler(null);
    return result;
  }

  @override
  Future<bool> checkHasEmojiKeyboard() async {
    final result = await _methodChannel.invokeMethod<bool>('hasEmojiKeyboard');
    return result ?? false;
  }

  @override
  Future<void> closeEmojiKeyboard() {
    return _methodChannel.invokeMethod<void>('closeEmojiKeyboard');
  }

  Future<dynamic> Function(MethodCall call)? _createMethodCallHandler(
    Completer completer,
  ) {
    return (call) async {
      final method = MethodCallName.fromString(call.method);

      switch (method) {
        case MethodCallName.emojiPicked:
          return completer.complete(call.arguments['emoji']);
        case MethodCallName.emojiPickerClosed:
          return completer.complete(null);
        case MethodCallName.openingKeyboardFailed:
          final failure = call.arguments['failure'];
          if (failure == 'noEmojiKeyboard') {
            return completer.completeError(const NoEmojiKeyboardFound());
          } else {
            return completer.completeError(const UnknownError());
          }
        case null:
          break;
      }
    };
  }
}
