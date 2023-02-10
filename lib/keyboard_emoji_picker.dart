import 'keyboard_emoji_picker_platform_interface.dart';
export 'src/keyboard_emoji_picker_wrapper.dart';

class KeyboardEmojiPicker {
  Future<String?> getPlatformVersion() {
    return KeyboardEmojiPickerPlatform.instance.getPlatformVersion();
  }
}
