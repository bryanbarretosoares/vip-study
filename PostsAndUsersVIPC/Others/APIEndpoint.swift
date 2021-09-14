//
//  APIEndpoint.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var endpoint: String { get }
    var fullPath: String { get }
}

extension APIEndpoint {
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var fullPath: String {
        return baseURL + endpoint
    }
}
