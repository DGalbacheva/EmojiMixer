//
//  ViewController.swift
//  EmojiMixer
//
//  Created by Doroteya Galbacheva on 31.10.2024.
//

import UIKit

final class EmojiMixesViewController: UIViewController {
    private var viewModel: EmojiMixesViewModel!

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
            let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEmojiMix))
            navBar.topItem?.setRightBarButton(rightButton, animated: false)

            let leftButton = UIBarButtonItem(
                title: NSLocalizedString("Delete All", comment: ""),
                style: .plain,
                target: self,
                action: #selector(deleteAll)
            )
            navBar.topItem?.setLeftBarButton(leftButton, animated: false)

        }
        setupCollectionView()
        viewModel = EmojiMixesViewModel()
        viewModel.emojiMixesBinding = { [weak self] _ in
            guard let self = self else { return }
            self.collectionView.reloadData()
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

        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @objc
    private func addNewEmojiMix() {
        viewModel.addEmojiMixTapped()
    }

    @objc
    private func deleteAll() {
        viewModel.deleteAll()
    }
}

extension EmojiMixesViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.emojiMixes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EmojiMixCollectionViewCell
        cell.viewModel = viewModel.emojiMixes[indexPath.item]
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
        let insets = collectionView.contentInset
        let availableWidth = collectionView.bounds.width - insets.left - insets.right
        let minSpacing = 10.0
        let itemsPerRow = 2.0
        let itemWidth = (availableWidth - (itemsPerRow - 1) * minSpacing)  / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10.0
    }
}
