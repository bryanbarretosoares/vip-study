//
//  PostDetailFactory.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

enum PostDetailFactory {
    static func make(post: Post) -> UIViewController {
        let controller = PostDetailViewController(post: post)
        return controller
    }
}
