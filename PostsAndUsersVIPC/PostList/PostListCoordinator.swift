//
//  PostListCoordinator.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

enum coordinatorActions {
    case userDetail(id: Int)
    case postDetail(post: Post)
}

protocol PostListCoordinating: AnyObject {
    var viewController: UIViewController? { get }
    
    func perform(action: coordinatorActions)
}

class PostListCoordinator {
    weak var viewController: UIViewController?
}

extension PostListCoordinator: PostListCoordinating {
    func perform(action: coordinatorActions) {
        switch action {
        case .userDetail(let id):
            break
        case .postDetail(let post):
            let vc = PostDetailFactory.make(post: post)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
