//
//  Mocks.swift
//  QuandooTechTaskTests
//
//  Created by Jakub Sędal on 29/02/2024.
//

import Foundation
@testable import QuandooTechTask
@testable import Services

public class ServiceManagerMock: ServiceManaging {
    var expectedPostsResult: [Services.Post] = []
    var expectedUsersResult: [Services.User] = []
    var didFetchDataCalled: Bool = false
    var shouldFail = false
    var didFetchDataCallCount: Int = 0
    public func fetchData<T: Decodable>(for fetchingType: Services.FetchingType, completion: @escaping (Result<[T], Services.APIError>) -> Void) {
        didFetchDataCalled = true
        didFetchDataCallCount += 1
        switch (fetchingType, shouldFail)  {
        case (_, true):
            completion(.failure(.networkError))
        case (.posts(_), false):
            expectedPostsResult.isEmpty
            ? completion(.failure(.noData))
            : completion(.success(expectedPostsResult as! [T]))
        case (.users, false):
            expectedUsersResult.isEmpty
            ? completion(.failure(.noData))
            : completion(.success(expectedUsersResult as! [T]))
        }
    }
}

extension QuandooTechTask.User {
    static var mock: QuandooTechTask.User {
        return QuandooTechTask.User(id: 1, name: "John Doe", username: "John99", email: "john@email.com", address: "")
    }
}

extension Services.User {
    static var mock: Services.User {
        self.init(
            id: 99,
            name: "John Doe",
            username: "John99",
            email: "john@email.com",
            address: .init(
                street: "Bakery Street",
                suite: "2",
                city: "London",
                zipcode: "111",
                geo: .init(lat: "", lng: "")
            ),
            phone: "111222333",
            website: "www.site.com",
            company: .init(
                name: "John's Bakery",
                catchPhrase: "",
                bs: ""
            )
        )
    }
}
    
