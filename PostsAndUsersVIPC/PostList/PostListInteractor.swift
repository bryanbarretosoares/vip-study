//
//  PostListInteractor.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

protocol PostListInteracting {
    func didLoad()
    func fetchPosts()
    func didSelectPost(_ post: Post)
}

class PostListInteractor {
    
    let presenter: PostListPresenting
    let service: PostListServicing
    var posts: [Post] = []
    
    init(presenter: PostListPresenting, service: PostListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension PostListInteractor: PostListInteracting {
    func didLoad() {
        presenter.initialConfig()
    }
    
    func fetchPosts() {
        service.fetchPosts()
    }
    
    func didSelectPost(_ post: Post) {
        presenter.showPostDetail(post: post)
    }
}

extension PostListInteractor: PostListServiceDelegate {
    func didFetch(data: [Post]) {
        self.posts = data
        presenter.presentPosts(data)
    }
    
    func didFail(with error: Error) {
        presenter.presentError(error)
    }
}
