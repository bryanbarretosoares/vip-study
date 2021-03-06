//
//  PostListFactory.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

enum PostListFactory {
    static func make() -> UIViewController {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let coordinator = PostListCoordinator()
        let network = Network(session: session, decoder: decoder)
        let service = PostListService(network: network)
        let presenter = PostListPresenter(coordinator: coordinator)
        let interactor = PostListInteractor(presenter: presenter, service: service)
        let viewController = PostListViewController(interactor: interactor)
        coordinator.viewController = viewController
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        service.delegate = interactor
        return viewController
    }
}
