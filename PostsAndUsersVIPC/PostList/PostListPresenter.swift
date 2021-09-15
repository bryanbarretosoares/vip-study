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
    func presentPosts(_ postList: [Post])
    func showPostDetail(post: Post)
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
    
    func presentPosts(_ postList: [Post]) {
        viewController?.displayPosts(postList)
    }
    
    func showPostDetail(post: Post) {
        coordinator.perform(action: .postDetail(post: post))
    }
}
