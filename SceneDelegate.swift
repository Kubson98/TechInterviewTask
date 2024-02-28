//
//  SceneDelegate.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let dependencies = Dependencies()
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(
            navigationController: navigationController,
            dependencies: dependencies
        )
        coordinator?.start()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
