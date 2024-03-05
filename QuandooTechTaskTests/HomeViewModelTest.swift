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
        XCTAssertTrue(service.didFetchDataCallCount == 1)
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
        assert(sut.userRowData(at: 0)?.name == "John Doe")
        XCTAssertTrue(finalStatus == .fetched)
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
        assert(sut.userRowData(at: 0) == nil)
        XCTAssertTrue(finalStatus == .empty)
    }
    
    func testFetchUsers_whenProblemWithConnectionExist_statusShouldBeError() throws {
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
        assert(sut.userRowData(at: 0) == nil)
        assert(finalStatus == .error)
    }
}
