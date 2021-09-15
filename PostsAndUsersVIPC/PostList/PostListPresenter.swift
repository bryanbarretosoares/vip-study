//
//  PostListPresenter.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

protocol PostListPresenting {
    var viewController: PostListDisplaying? { get }
    func presentError(_ error: Error)
    func presentPosts(_ postList: [PostModel])
    func showPostDetail(post: PostModel)
}

class PostListPresenter {
    weak var viewController: PostListDisplaying?
    private let coordinator: PostListCoordinating
    
    init(coordinator: PostListCoordinating) {
        self.coordinator = coordinator
    }
    
}

extension PostListPresenter: PostListPresenting {
    
    func presentError(_ error: Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
    
    func presentPosts(_ postList: [PostModel]) {
        viewController?.displayPosts(postList)
    }
    
    func showPostDetail(post: PostModel) {
        coordinator.perform(action: .postDetail(post: post))
    }
}
