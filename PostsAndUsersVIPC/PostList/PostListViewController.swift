//
//  PostListViewController.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

protocol PostListDisplaying: AnyObject {
    func displayError(message: String)
    func displayPosts(_ posts: [Post])
    func setTitle(_ title: String)
    func setBackgroundColor(_ color: UIColor)
}

class PostListViewController: UIViewController {
    
    let interactor: PostListInteracting
    var posts: [Post] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(PostListCell.self, forCellReuseIdentifier: PostListCell.id)
        table.tableFooterView = UIView()
        table.backgroundView = loading
        return table
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView()
        ac.startAnimating()
        ac.hidesWhenStopped = true
        return ac
    }()
    
    init(interactor: PostListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.didLoad()
        interactor.fetchPosts()
        buildLayout()
    }
}

extension PostListViewController: PostListDisplaying {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func displayError(message: String) {
        print(message)
    }
    
    func displayPosts(_ posts: [Post]) {
        self.posts = posts
        self.tableView.reloadData()
        self.loading.stopAnimating()
    }
}

extension PostListViewController: ViewCoding {
    func viewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.frame = view.frame
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.id, for: indexPath) as? PostListCell
        cell?.configure(post: post)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}

extension PostListViewController: UITableViewDelegate {
    
}
