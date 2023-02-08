import 'package:flutter_test/flutter_test.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker_platform_interface.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKeyboardEmojiPickerPlatform
    with MockPlatformInterfaceMixin
    implements KeyboardEmojiPickerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KeyboardEmojiPickerPlatform initialPlatform = KeyboardEmojiPickerPlatform.instance;

  test('$MethodChannelKeyboardEmojiPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeyboardEmojiPicker>());
  });

  test('getPlatformVersion', () async {
    KeyboardEmojiPicker keyboardEmojiPickerPlugin = KeyboardEmojiPicker();
    MockKeyboardEmojiPickerPlatform fakePlatform = MockKeyboardEmojiPickerPlatform();
    KeyboardEmojiPickerPlatform.instance = fakePlatform;

    expect(await keyboardEmojiPickerPlugin.getPlatformVersion(), '42');
  });
}
