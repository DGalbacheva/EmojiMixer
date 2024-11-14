//
//  EmojiMixViewModel.swift
//  EmojiMixer
//
//  Created by MacBook Pro 15 on 14.11.2024.
//

import UIKit

final class EmojiMixViewModel: Identifiable {
    let id: String
    private var emojis: String
    private var backgroundColor: UIColor
    
    init(id: String, emojis: String, backgroundColor: UIColor) {
        self.id = id
        self.emojis = emojis
        self.backgroundColor = backgroundColor
    }
    
    var emojiBinding: Binding<String>? {
        didSet {
            emojiBinding?(emojis)
        }
    }
    
    var backgroundColorBinding: Binding<UIColor>? {
        didSet {
            backgroundColorBinding?(backgroundColor)
        }
    }
}
