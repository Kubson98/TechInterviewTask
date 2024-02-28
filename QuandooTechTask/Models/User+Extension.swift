//
//  User+Extension.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 26/02/2024.
//

import Services

public extension User {
    init(user: Services.User) {
        self.init(
            id: user.id,
            name: user.name,
            username: user.username,
            email: user.email,
            address: user.address.presentableAddress
        )
    }
}
