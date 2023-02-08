import Flutter
import UIKit

public class KeyboardEmojiPickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "keyboard_emoji_picker", binaryMessenger: registrar.messenger())
    let instance = KeyboardEmojiPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
