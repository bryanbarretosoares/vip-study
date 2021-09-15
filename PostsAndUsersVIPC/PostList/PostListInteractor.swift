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
        service.fetchPosts()
    }
    
    func didSelectPost(_ post: PostModel) {
        presenter.showPostDetail(post: post)
    }
}

extension PostListInteractor: PostListServiceDelegate {
    func didFetch(data: [PostModel]) {
        presenter.presentPosts(data)
    }
    
    func didFail(with error: Error) {
        presenter.presentError(error)
    }
}
