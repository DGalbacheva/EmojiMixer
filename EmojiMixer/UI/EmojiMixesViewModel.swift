//
//  EmojiMixesViewModel.swift
//  EmojiMixer
//
//  Created by Doroteya Galbacheva on 14.11.2024.
//

import UIKit

final class EmojiMixesViewModel {

    private let emojiMixStore: EmojiMixStore
    private let emojiMixFactory: EmojiMixFactory
    private let uiColorMarshalling = UIColorMarshalling()

    private(set) var emojiMixes: [EmojiMixViewModel] = [] {
        didSet {
            emojiMixesBinding?(emojiMixes)
        }
    }
    
    var emojiMixesBinding: Binding<[EmojiMixViewModel]>?
    
    convenience init() {
        let emojiMixStore = try! EmojiMixStore(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        self.init(emojiMixStore: emojiMixStore, emojiMixFactory: EmojiMixFactory())
    }

    init(emojiMixStore: EmojiMixStore, emojiMixFactory: EmojiMixFactory) {
        self.emojiMixStore = emojiMixStore
        self.emojiMixFactory = emojiMixFactory
        emojiMixStore.delegate = self
        emojiMixes = getEmojiMixesFromStore()
    }

    func addEmojiMixTapped() {
        let newMix = emojiMixFactory.makeNewMix()
        try! emojiMixStore.addNewEmojiMix(newMix.emojies, color: newMix.backgroundColor)
    }

    func deleteAll() {
        try! emojiMixStore.deleteAll()
    }

    private func getEmojiMixesFromStore() -> [EmojiMixViewModel] {
        return emojiMixStore.emojiMixes.map {
            EmojiMixViewModel(
                id: $0.objectID.uriRepresentation().absoluteString,
                emojis: $0.emojies ?? "",
                backgroundColor: uiColorMarshalling.color(from: $0.colorHex ?? "")
            )
        }
    }
}

extension EmojiMixesViewModel: EmojiMixStoreDelegate {
    func storeDidUpdate(_ store: EmojiMixStore) {
        emojiMixes = getEmojiMixesFromStore()
    }
}

