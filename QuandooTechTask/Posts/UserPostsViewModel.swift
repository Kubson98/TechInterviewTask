//
//  UserPostsViewModel.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 27/02/2024.
//

import Foundation
import Services

class UserPostsViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published var fetchingStatus: FetchingStatus = .loading
    private let service: ServiceManaging
    private var userId: Int
    
    init(
        userId: Int,
        service: ServiceManaging
    ) {
        self.userId = userId
        self.service = service
        fetchPosts()
    }
    
    func fetchPosts() {
        fetchingStatus = .loading
        service.fetchData(for: .posts(userId), completion: { [weak self] (result: Result<[Services.Post], APIError>) in
            switch result {
            case .success(let response):
                let posts = response.map { Post.init(user: $0) }
                DispatchQueue.main.async {
                    self?.posts = posts
                    self?.fetchingStatus = posts.isEmpty ? .empty : .fetched
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.fetchingStatus = .error
                }
            }
        })
    }
}
