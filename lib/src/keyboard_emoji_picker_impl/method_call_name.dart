enum MethodCallName {
  emojiPicked('emojiPicked'),
  emojiPickerClosed('emojiPickerClosed'),
  openingKeyboardFailed('openingKeyboardFailed');

  const MethodCallName(this.methodName);

  static MethodCallName? fromString(String methodName) {
    return values.firstWhere((element) => element.methodName == methodName);
  }

  final String methodName;
}
