/// No emoji keyboard was found. In order to avoid this,
/// check if the device has an emoji keyboard before trying to pick an emoji.
///
/// See [KeyboardEmojiPicker.checkHasEmojiKeyboard].
class NoEmojiKeyboardFound implements Exception {
  const NoEmojiKeyboardFound();

  @override
  String toString() {
    return 'No emoji keyboard found';
  }
}

/// An unknown error occurred.
class UnknownError implements Exception {
  const UnknownError();

  @override
  String toString() {
    return 'Unknown error';
  }
}
