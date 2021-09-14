//
//  PostListService.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

protocol PostListServicing {
    var delegate: PostListServiceDelegate? { get }
    func fetchPosts()
}

protocol PostListServiceDelegate: AnyObject {
    func didFetch(data: [Post])
    func didFail(with error: Error)
}

enum PostEndpoint: APIEndpoint {
    case getPost
    
    var endpoint: String {
        switch self {
        case .getPost:
            return "/posts"
        }
    }
}

class PostListService {
    
    let network: Network
    weak var delegate: PostListServiceDelegate?
    
    init(network: Network = Network()) {
        self.network = network
    }
}

extension PostListService: PostListServicing {
    func fetchPosts() {
        let endpoint: PostEndpoint = .getPost
        network.fetchData(endpoint: endpoint) { (result: Result<[Post], APIError>) in
            DispatchQueue.main.async {
                switch result {
                case let .success(posts):
                    self.delegate?.didFetch(data: posts)
                case let .failure(error):
                    self.delegate?.didFail(with: error)
                }
            }
        }
    }
}
