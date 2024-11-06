//
//  ViewController.swift
//  EmojiMixer
//
//  Created by Doroteya Galbacheva on 31.10.2024.
//

import UIKit

final class EmojiMixesViewController: UIViewController {
    private let emojies = [
        "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒",
        "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️",
        "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"
    ]
    
    private var visibleEmojis: [String] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(EmojiMixCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navBar = navigationController?.navigationBar {
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNextEmoji))
            navBar.topItem?.setRightBarButton(rightButton, animated: false)
            
            let leftButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(removeLastEmoji))
            navBar.topItem?.setLeftBarButton(leftButton, animated: false)
        }
        setupCollectionView()
    }
    
    @objc
    private func addNextEmoji() {
        guard visibleEmojis.count < emojies.count else { return }
        
        let nextEmojiIndex = visibleEmojis.count
        visibleEmojis.append(emojies[nextEmojiIndex])
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [IndexPath(item: nextEmojiIndex, section: 0)])
        }
    }
    
    @objc
    private func removeLastEmoji() {
        guard visibleEmojis.count > 0 else { return }
        
        let lastEmojiIndex = visibleEmojis.count - 1
        visibleEmojis.removeLast()
        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [IndexPath(item: lastEmojiIndex, section: 0)])
        }
    }
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension EmojiMixesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return visibleEmojis.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojiMixCollectionViewCell
        
        cell.titleLabel.text = visibleEmojis[indexPath.row]
        return cell
    }
}

extension EmojiMixesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}


extension EmojiMixesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 50)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}

