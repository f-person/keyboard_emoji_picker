/// No emoji keyboard was found. In order to avoid this,
/// check if the device has an emoji keyboard before trying to pick an emoji.
///
/// See [KeyboardEmojiPicker.checkHasEmojiKeyboard].
class NoEmojiKeyboardFound implements Exception {
  const NoEmojiKeyboardFound();

  @override
  String toString() {
    return '''
No emoji keyboard found.
To avoid this exception, check for if the device has an emoji keyboard before trying to pick an emoji.
You can do this using the [KeyboardEmojiPicker.checkHasEmojiKeyboard] method.

Example:
```
final hasEmojiKeyboard = await KeyboardEmojiPicker().checkHasEmojiKeyboard();

if (hasEmojiKeyboard) {
  final emoji = await KeyboardEmojiPicker().pickEmoji();
  if (emoji != null) {
    // Do something with the emoji
  } else {
    // The emoji picking process was cancelled.
  }
} else {
  // Show a custom emoji picker (e. g. made in Flutter)
}
```
    ''';
  }
}

/// An unknown error occurred. Shouldn't happen.
class UnknownError implements Exception {
  const UnknownError();

  @override
  String toString() {
    return '''
An unknown error occurred.
Please report this issue with a stack trace at the GitHub repository's "Issues" page.
''';
  }
}
