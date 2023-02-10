import Flutter
import UIKit

public class KeyboardEmojiPickerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "keyboard_emoji_picker", binaryMessenger: registrar.messenger())
        let instance = KeyboardEmojiPickerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let factory = FLNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "fperson.dev/keyboard_emoji_picker")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS-mayOS " + UIDevice.current.systemVersion)
    }
}

