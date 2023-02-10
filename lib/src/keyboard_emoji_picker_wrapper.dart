import 'package:flutter/material.dart';

class KeyboardEmojiPickerWrapper extends StatelessWidget {
  const KeyboardEmojiPickerWrapper({required this.child, super.key});

  final Widget child;

  // This is used in the platform side to register the view.
  static const _viewType = 'fperson.dev/keyboard_emoji_picker';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.shrink(
          child: UiKitView(viewType: _viewType),
        ),
        child,
      ],
    );
  }
}
