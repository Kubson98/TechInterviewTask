//
//  Post.swift
//  Services
//
//  Created by Jakub Sędal on 26/02/2024.
//

public struct Post: Decodable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
}
