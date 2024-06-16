//
//  HomeViewModelTests.swift
//  QuandooTechTaskTests
//
//  Created by Jakub Sędal on 28/02/2024.
//

import XCTest
import Combine
@testable import QuandooTechTask
@testable import Services

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var service: ServiceManagerMock!
    private var usersCancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        service = ServiceManagerMock()
        usersCancellables = []
        sut = .init(service: service)
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        usersCancellables.removeAll()
        super.tearDown()
    }
    

    func testFetchUsers_shouldCall_counterShouldBeEqualOne() throws {
        // given
        service.expectedUsersResult = [.mock]
        // when
        sut.fetchUsers()
        // then
        assert(service.didFetchDataCallCount == 1)
        XCTAssertTrue(service.didFetchDataCalled == true)
    }
    
    func testFetchUsers_whenDataExist_statusShouldBeFetched() throws {
        // given
        service.expectedUsersResult = [.mock]
        var finalStatus: FetchingStatus = .loading
        // when
        sut.fetchingClientsStatus.sink { status in
            finalStatus = status
        }.store(in: &usersCancellables)
        sut.fetchUsers()
        // then
        XCTAssertTrue(finalStatus == .fetched)
    }
    
    func testFetchUsers_whenDataExist_nameOfUserShouldBeAsExpected() throws {
        // given
        service.expectedUsersResult = [.mock]
        // when
        sut.fetchUsers()
        // then
        assert(sut.users[0].name == "John Doe")
    }
    
    func testFetchUsers_whenDataExist_numberOfUsersShouldBeOne() throws {
        // given
        service.expectedUsersResult = [.mock]
        // when
        sut.fetchUsers()
        // then
        assert(sut.users.count == 1)
    }
    
    func testFetchUsers_whenDataDoesNotExist_statusShouldBeEmpty() throws {
        // given
        service.expectedUsersResult = []
        var finalStatus: FetchingStatus = .loading
        // when
        sut.fetchingClientsStatus.sink { status in
            finalStatus = status
        }.store(in: &usersCancellables)
        sut.fetchUsers()
        // then
        XCTAssertTrue(finalStatus == .empty)
    }
    
    func testFetchUsers_whenDataDoesNotExist_usersDataShouldBeEmpty() throws {
        // given
        service.expectedUsersResult = []
        // when
        sut.fetchUsers()
        // then
        XCTAssertTrue(sut.users.isEmpty )
    }
    
    func testFetchUsers_whenDataDoesNotExist_numberOfUsersShouldBeZero() throws {
        // given
        service.expectedUsersResult = []
        // when
        sut.fetchUsers()
        // then
        assert(sut.users.count == 0)
    }
    
    func testFetchUsers_whenProblemWithFetchingExists_statusShouldBeError() throws {
        // given
        service.expectedUsersResult = []
        service.shouldFail = true
        var finalStatus: FetchingStatus = .loading
        // when
        sut.fetchingClientsStatus.sink { status in
            finalStatus = status
        }.store(in: &usersCancellables)
        sut.fetchUsers()
        // then
        assert(finalStatus == .error)
    }
    
    func testFetchUsers_whenProblemWithFetchingExists_usersDataShouldBeEmpty() throws {
        // given
        service.expectedUsersResult = []
        service.shouldFail = true
        // when
        sut.fetchUsers()
        // then
        XCTAssertTrue(sut.users.isEmpty)
    }
    
    func testFetchUsers_whenProblemWithFetchingExists_numberOfUsersShouldBeZero() throws {
        // given
        service.expectedUsersResult = []
        service.shouldFail = true
        // when
        sut.fetchUsers()
        // then
        assert(sut.users.count == 0)
    }
}
