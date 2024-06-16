//
//  HomeViewModel.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

import Combine
import Foundation
import Services

enum FetchingStatus {
    case fetched
    case loading
    case empty
    case error
}

class HomeViewModel {
    var fetchingClientsStatus: AnyPublisher<FetchingStatus, Never> { 
        fetchingClientsSubject.eraseToAnyPublisher()
    }
    private let fetchingClientsSubject = PassthroughSubject<FetchingStatus, Never>()
    private(set) var users: [User] = []
    private let service: ServiceManaging
    
    init(users: [User] = [], service: ServiceManaging) {
        self.users = users
        self.service = service
    }
    
    func fetchUsers() {
        fetchingClientsSubject.send(.loading)
        service.fetchData(for: .users, completion: { [unowned self] (result: Result<[Services.User], APIError>) in
            switch result {
            case .success(let response):
                let users = response.map { User.init(user: $0) }
                self.users = users
                users.isEmpty
                ? fetchingClientsSubject.send(.empty)
                : fetchingClientsSubject.send(.fetched)
            case .failure:
                fetchingClientsSubject.send(.error)
            }
        })
    }
}
