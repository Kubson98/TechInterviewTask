//
//  HomeViewModelTests.swift
//  QuandooTechTaskTests
//
//  Created by Jakub Sędal on 28/02/2024.
//

import XCTest
@testable import QuandooTechTask
@testable import Services

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var service: ServiceManagerMock!
    
    override func setUp() {
        super.setUp()
        service = ServiceManagerMock()
        sut = .init(service: service)
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
    

    func testFetchUsers_shouldCall() throws {
        // given
        service.expectedUsersResult = [.mock]
        // when
        sut.fetchUsers()
        // then
        XCTAssertTrue(service.didFetchDataCallCount == 1)
        XCTAssertTrue(service.didFetchDataCalled)
    }
    
    func testFetchUsers_whenDataExist() throws {
        // given
        service.expectedUsersResult = [.mock]
        // when
        sut.fetchUsers()
        // then
        assert(sut.userRowData(at: 0)?.name == "John Doe")
    }
    
    func testFetchUsers_whenDataDoesNotExist() throws {
        // given
        service.expectedUsersResult = []
        // when
        sut.fetchUsers()
        // then
        assert(sut.userRowData(at: 0) == nil)
    }

}

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
    
