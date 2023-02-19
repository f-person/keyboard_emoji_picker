import Flutter
import UIKit

public class KeyboardEmojiPickerPlugin: NSObject, FlutterPlugin {
    public static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "keyboard_emoji_picker", binaryMessenger: registrar.messenger())
        
        let instance = KeyboardEmojiPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
        
        let factory = KeyboardNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "fperson.dev/keyboard_emoji_picker")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "pickEmoji":
            if (checkHasEmojiKeyboard()) {
                KeyboardNativeView.inputView.focus()
            } else {
                KeyboardEmojiPickerPlugin.channel?.invokeMethod("openingKeyboardFailed", arguments: ["failure": "noEmojiKeyboard"])
            }
        case "hasEmojiKeyboard":
            let hasEmojiKeyboard = checkHasEmojiKeyboard()
            result(hasEmojiKeyboard)
        case "closeEmojiKeyboard":
            KeyboardNativeView.inputView.unFocus()
            result(nil)
        default:
            KeyboardEmojiPickerPlugin.channel?.invokeMethod("unknownMethod", arguments: ["methodName": call.method])
        }
    }
    
    private func checkHasEmojiKeyboard() -> Bool {
        let modes = UITextInputMode.activeInputModes
        let hasEmojiKeyboard = modes.contains(where: { $0.primaryLanguage == "emoji" })
        
        return hasEmojiKeyboard
    }
}

