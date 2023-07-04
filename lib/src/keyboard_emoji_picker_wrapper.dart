import 'package:flutter/material.dart';

import 'keyboard_emoji_picker.dart';

/// Makes it possible to open the native emoji keyboard on iOS.
/// It is safe to use it on Android or other platforms for which
/// there is no implementation.
///
/// This wrapper widget doesn't change the actual UI of your app.
/// You need to have it widget somewhere in your widget tree in order
/// for the native emoji keyboard to work.
class KeyboardEmojiPickerWrapper extends StatelessWidget {
  const KeyboardEmojiPickerWrapper({required this.child, super.key});

  /// The widget you want to be displayed.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isSupported = KeyboardEmojiPicker().checkIsPlatformSupported();
    if (!isSupported) {
      return child;
    }

    const viewType = 'fperson.dev/keyboard_emoji_picker';

    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: Stack(
        children: [
          const SizedBox.shrink(
            child: UiKitView(viewType: viewType),
          ),
          child,
        ],
      ),
    );
  }
}
