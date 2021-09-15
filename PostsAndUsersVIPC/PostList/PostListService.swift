//
//  PostListService.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

protocol PostListServicing {
    func fetchPosts(completion: @escaping (Result<[PostModel], APIError>) -> Void)
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
    
    private let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
}

extension PostListService: PostListServicing {
    
    func fetchPosts(completion: @escaping (Result<[PostModel], APIError>) -> Void) {
        let endpoint: PostEndpoint = .getPost
        _ = network.fetchData(endpoint: endpoint) { (result: Result<[PostModel], APIError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
