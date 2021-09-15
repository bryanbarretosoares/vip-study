//
//  PostListInteractor.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

protocol PostListInteracting {
    func fetchPosts()
    func didSelectPost(_ post: PostModel)
}

class PostListInteractor {
    
    private let presenter: PostListPresenting
    private let service: PostListServicing
    
    init(presenter: PostListPresenting, service: PostListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension PostListInteractor: PostListInteracting {
    
    func fetchPosts() {
        service.fetchPosts { [weak self] result in
            switch result {
            case let .success(postModels):
                self?.presenter.presentPosts(postModels)
            case let .failure(error):
                self?.presenter.presentError(error)
            }
        }
    }
    
    func didSelectPost(_ post: PostModel) {
        presenter.showPostDetail(post: post)
    }
}
