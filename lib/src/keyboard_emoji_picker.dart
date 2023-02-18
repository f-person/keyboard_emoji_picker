import 'package:keyboard_emoji_picker/src/keyboard_emoji_picker_impl/keyboard_emoji_picker_impl.dart';

/// `KeyboardEmojiPicker` is a class that lets you to pick an emoji
/// using the device's native emoji keyboard.
///
/// It is required to have [KeyboardEmojiPickerWrapper] somewhere in your widget tree.
/// Otherwise, the plugin will not work.
///
/// Since sometimes the emoji keyboard is not available, it is recommended
/// to check if the device has an emoji keyboard before trying to pick an emoji
/// via [checkHasEmojiKeyboard].
/// Otherwise, [pickEmoji] will throw a [NoEmojiKeyboardFound] error:
///
/// ```dart
/// final hasEmojiKeyboard = await KeyboardEmojiPicker.instance.checkHasEmojiKeyboard();
///
/// if (hasEmojiKeyboard) {
///   final emoji = await KeyboardEmojiPicker.instance.pickEmoji();
///   if (emoji != null) {
///     // Do something with the emoji
///   } else {
///     // The emoji picking process was cancelled.
///   }
/// } else {
///   // Show a custom emoji picker (e. g. made in Flutter)
/// }
/// ```
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
