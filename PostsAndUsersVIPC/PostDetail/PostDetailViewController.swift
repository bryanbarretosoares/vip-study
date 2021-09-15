//
//  PostDetailViewController.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let post: PostModel
    
    private lazy var titleLabel: UILabel = {
        return buildLabel(font: UIFont.systemFont(ofSize: 20, weight: .bold), lines: 0)
    }()
    
    private lazy var bodyLabel: UILabel = {
        return buildLabel(font: UIFont.systemFont(ofSize: 17, weight: .thin), lines: 0)
    }()
    
    private lazy var idLabel: UILabel = {
        return buildLabel(font: UIFont.systemFont(ofSize: 14, weight: .thin), lines: 0)
    }()
    
    private lazy var postIdLabel: UILabel = {
        return buildLabel(font: UIFont.systemFont(ofSize: 14, weight: .ultraLight), lines: 0)
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [postIdLabel, idLabel, titleLabel, bodyLabel])
        stack.axis = .vertical
        stack.spacing = 50
        stack.setCustomSpacing(0, after: postIdLabel)
        stack.setCustomSpacing(8, after: titleLabel)
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        configureView()
        title = post.title
        view.backgroundColor = .systemBackground
    }
    
    private func buildLabel(font: UIFont = UIFont.systemFont(ofSize: 18, weight: .regular), lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.numberOfLines = lines
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func configureView() {
       bodyLabel.text = post.body
        idLabel.text = "User ID: \(post.userId)"
        titleLabel.text = post.title
        postIdLabel.text = "Post ID: \(post.id)"
    }
}

extension PostDetailViewController: ViewCoding {
    func viewHierarchy() {
        view.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
