import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keyboard_emoji_picker/keyboard_emoji_picker_method_channel.dart';

void main() {
  MethodChannelKeyboardEmojiPicker platform = MethodChannelKeyboardEmojiPicker();
  const MethodChannel channel = MethodChannel('keyboard_emoji_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
