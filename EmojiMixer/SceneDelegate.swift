//
//  SceneDelegate.swift
//  EmojiMixer
//
//  Created by Doroteya Galbacheva on 31.10.2024.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let viewController = EmojiMixesViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
