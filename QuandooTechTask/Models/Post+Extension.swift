//
//  Post+Extension.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 26/02/2024.
//

import Services

extension Post {
    init(user: Services.Post) {
        self.init(
            id: user.id,
            title: user.title,
            body: user.body
        )
    }
}
