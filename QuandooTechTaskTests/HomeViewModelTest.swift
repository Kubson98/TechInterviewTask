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
