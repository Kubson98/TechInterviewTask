//
//  UserPostsViewModel.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 27/02/2024.
//

import Combine
import Foundation
import Services

class UserPostsViewModel {
    var fetchingPostsStatus: AnyPublisher<FetchingStatus, Never> { fetchingPostsSubject.eraseToAnyPublisher() }
    private let fetchingPostsSubject = PassthroughSubject<FetchingStatus, Never>()
    private(set) var posts: [Post] = []
    private let service: ServiceManaging
    private var userId: Int
    
    init(userId: Int, service: ServiceManaging) {
        self.userId = userId
        self.service = service
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func postRowData(at index: Int) -> Post? {
        guard index >= 0 && index < numberOfPosts() else { return nil }
        return posts[index]
    }
    
    func fetchPosts() {
        fetchingPostsSubject.send(.loading)
        service.fetchData(for: .posts(userId), completion: { [unowned self] (result: Result<[Services.Post], APIError>) in
            switch result {
            case .success(let response):
                let posts = response.map { Post.init(user: $0) }
                self.posts = posts
                posts.isEmpty
                ? fetchingPostsSubject.send(.empty)
                : fetchingPostsSubject.send(.fetched)
            case .failure:
                fetchingPostsSubject.send(.error)
            }
        })
    }
}
