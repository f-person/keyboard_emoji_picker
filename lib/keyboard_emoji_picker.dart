
import 'keyboard_emoji_picker_platform_interface.dart';

class KeyboardEmojiPicker {
  Future<String?> getPlatformVersion() {
    return KeyboardEmojiPickerPlatform.instance.getPlatformVersion();
  }
}
