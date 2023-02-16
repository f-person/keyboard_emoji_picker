import 'package:keyboard_emoji_picker/src/keyboard_emoji_picker_impl/keyboard_emoji_picker_impl.dart';

// TODO(f-person): Add documentation with examples.
abstract class KeyboardEmojiPicker {
  /// A shortcut to the default singleton instance of [KeyboardEmojiPicker].
  factory KeyboardEmojiPicker() => _instance;

  /// Provides access to the default Singleton instance of [KeyboardEmojiPicker].
  static KeyboardEmojiPicker get instance => _instance;

  /// The default instance of [KeyboardEmojiPicker].
  /// Accessed through the [instance] getter.
  ///
  /// As it is lazily initialized, it will only be created once
  /// [instance] is accessed.
  static final KeyboardEmojiPicker _instance = KeyboardEmojiPickerImpl();

  /// Picks an emoji using the native emoji keyboard.
  ///
  /// Will throw [NoEmojiKeyboardFound] if no emoji keyboard is found.
  /// Preferably, check if the device has an emoji keyboard before trying
  /// to pick an emoji using this method. See [checkHasEmojiKeyboard].
  Future<String?> pickEmoji();

  /// Returns whether the device has an emoji keyboard.
  ///
  /// If the device doesn't have an emoji keyboard, you can
  /// show a custom emoji picker instead.
  Future<bool> checkHasEmojiKeyboard();

  /// Closes the emoji keyboard if it is open.
  Future<void> closeEmojiKeyboard();
}
