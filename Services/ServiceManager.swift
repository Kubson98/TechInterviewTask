//
//  ServiceManager.swift
//  Services
//
//  Created by Jakub Sędal on 26/02/2024.
//

import Foundation

public enum FetchingType {
    case users
    case posts(Int)
    
    var url: URL? {
        switch self {
        case .users:
            return URL(string: "https://jsonplaceholder.typicode.com/users")
        case .posts(let userId):
            return URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
        }
    }
}

public protocol ServiceManaging {
    func fetchData<T: Decodable>(for fetchingType: FetchingType, completion: @escaping (Result<[T], APIError>) -> Void)
}

public class ServiceManager: ServiceManaging {
    public func fetchData<T: Decodable>(for fetchingType: FetchingType, completion: @escaping (Result<[T], APIError>) -> Void) {
        guard let url = fetchingType.url else {
            completion(.failure(.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in            
            if let error = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    public init() {}
}
