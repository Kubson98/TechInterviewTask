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
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
    }
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
