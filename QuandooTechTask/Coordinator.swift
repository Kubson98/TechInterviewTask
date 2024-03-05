//
//  Coordinator.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 27/02/2024.
//

import SwiftUI

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let dependencies: Dependencies
    
    init(
        navigationController: UINavigationController,
        dependencies: Dependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let viewModel = HomeViewModel(service: dependencies.manager)
        let controller = HomeViewController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func buildUserPostsController(userId: Int) {
        let viewModel = UserPostsViewModel(userId: userId, service: dependencies.manager)
        let view = UserPostsView(
            viewModel: viewModel
        )
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
