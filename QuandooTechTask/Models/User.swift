//
//  User.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

public struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: String
}
