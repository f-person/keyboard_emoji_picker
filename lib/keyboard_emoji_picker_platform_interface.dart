import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keyboard_emoji_picker_method_channel.dart';

abstract class KeyboardEmojiPickerPlatform extends PlatformInterface {
  /// Constructs a KeyboardEmojiPickerPlatform.
  KeyboardEmojiPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeyboardEmojiPickerPlatform _instance = MethodChannelKeyboardEmojiPicker();

  /// The default instance of [KeyboardEmojiPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeyboardEmojiPicker].
  static KeyboardEmojiPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeyboardEmojiPickerPlatform] when
  /// they register themselves.
  static set instance(KeyboardEmojiPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
