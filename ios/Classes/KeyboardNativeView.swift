//
//  KeyboardNativeView.swift
//  keyboard_emoji_picker
//
//  Created by arshak ‎ on 10.02.23.
//

import Flutter
import UIKit

class KeyboardNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return KeyboardNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class KeyboardNativeView: NSObject, FlutterPlatformView {
    public static var inputView = EmojiChooserInput()
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        KeyboardNativeView.inputView.frame = CGRectZero
        
        super.init()
    }
    
    func view() -> UIView {
        return KeyboardNativeView.inputView
    }
}

final class EmojiChooserInput: UITextView {
    private static var isPickingEmoji = false
    
    override var textInputContextIdentifier: String? { "" }
    
    override func insertText(_ text: String) {
        print("\(text)")
        
        if (text.containsEmoji) {
            KeyboardEmojiPickerPlugin.channel?.invokeMethod("emojiPicked", arguments: ["emoji": text])
            EmojiChooserInput.isPickingEmoji = false
            resignFirstResponder()
        }
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        
        return nil
    }
    
    override func becomeFirstResponder() -> Bool {
        EmojiChooserInput.isPickingEmoji = true
        
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if (EmojiChooserInput.isPickingEmoji) {
            KeyboardEmojiPickerPlugin.channel?.invokeMethod("emojiPicked", arguments: ["emoji": nil])
            EmojiChooserInput.isPickingEmoji = false
        }
        
        return super.resignFirstResponder()
    }
}


extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    
    var containsEmoji: Bool { contains { $0.isEmoji } }
    
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    
    var emojis: [Character] { filter { $0.isEmoji } }
    
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}
