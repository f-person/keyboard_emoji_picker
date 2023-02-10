import Flutter
import UIKit

public class KeyboardEmojiPickerPlugin: NSObject, FlutterPlugin {
    public static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "keyboard_emoji_picker", binaryMessenger: registrar.messenger())
        
        let instance = KeyboardEmojiPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
        
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "fperson.dev/keyboard_emoji_picker")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call)
        
        KeyboardEmojiPickerPlugin.channel?.invokeMethod("openingKeyboardFailed", arguments: ["failure": "noEmojiKeyboard"])
        
        let modes = UITextInputMode.activeInputModes
        let hasEmojiKeyboard = modes.contains(where: { $0.primaryLanguage == "emoji" })
        print(hasEmojiKeyboard)
        print("hasEmojiKeyboard")
        
        if (hasEmojiKeyboard) {
            FLNativeView.button.becomeFirstResponder()
        } else {
            KeyboardEmojiPickerPlugin.channel?.invokeMethod("openingKeyboardFailed", arguments: ["failure": "noEmojiKeyboard"])
        }
    }
}

