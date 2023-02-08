import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keyboard_emoji_picker_platform_interface.dart';

/// An implementation of [KeyboardEmojiPickerPlatform] that uses method channels.
class MethodChannelKeyboardEmojiPicker extends KeyboardEmojiPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keyboard_emoji_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
