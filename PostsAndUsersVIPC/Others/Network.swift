//
//  Network.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

enum APIError: LocalizedError {
    case request
    case empty
    case server(Error)
    case parse(Error)
}

class Network {
    
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetchData<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let request = buildRequest(endpoint: endpoint) else {
            completion(.failure(.request))
            return
        }
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.server(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.empty))
                return
            }
            
            do {
                let decoded = try self.decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.parse(error)))
            }
        }
        task.resume()
    }
    
    private func buildRequest(endpoint: APIEndpoint) -> URLRequest? {
        guard let url = URL(string: endpoint.fullPath) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if endpoint.method != .get {
            request.httpBody = endpoint.body
        }
        
        for header in endpoint.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
