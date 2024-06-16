//
//  FetchingType.swift
//  Services
//
//  Created by Jakub Sędal on 16/06/2024.
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
