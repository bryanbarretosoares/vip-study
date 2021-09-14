//
//  PostListInteractor.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

protocol PostListInteracting: UITableViewDataSource, UITableViewDelegate {
    func didLoad()
    func fetchPosts()
    func didSelectPost(_ post: Post)
}

class PostListInteractor: NSObject {
    
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

extension PostListInteractor {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.id, for: indexPath) as? PostListCell
        let post = posts[indexPath.row]
        cell?.configure(post: post)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        presenter.showPostDetail(post: post)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
