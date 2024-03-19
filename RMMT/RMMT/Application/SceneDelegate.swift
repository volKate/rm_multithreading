//
//  SceneDelegate.swift
//  RMMT
//
//  Created by Kate Volkova on 18.03.24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(for: scene)
    }

    private func setupWindow(for scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = Task2ViewController()
        window?.makeKeyAndVisible()
    }
}

