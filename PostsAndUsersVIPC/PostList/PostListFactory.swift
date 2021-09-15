//
//  PostListFactory.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

enum PostListFactory {
    static func make() -> UIViewController {
        let coordinator = PostListCoordinator()
        let service = PostListService()
        let presenter = PostListPresenter(coordinator: coordinator)
        let interactor = PostListInteractor(presenter: presenter, service: service)
        let viewController = PostListViewController(interactor: interactor)
        coordinator.viewController = viewController
        presenter.viewController = viewController
        service.delegate = interactor
        return viewController
    }
}
