//
//  UserPostsViewModelTests.swift
//  QuandooTechTaskTests
//
//  Created by Jakub Sędal on 05/03/2024.
//

import XCTest
import Combine
@testable import QuandooTechTask
@testable import Services

final class UserPostsViewModelTests: XCTestCase {
    var sut: UserPostsViewModel!
    var service: ServiceManagerMock!
    var userId: Int!
    
    override func setUp() {
        super.setUp()
        service = ServiceManagerMock()
        userId = 1
        sut = .init(
            userId: userId,
            service: service
        )
    }
    
    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
    

    func testFetchPosts_shouldCall_counterShouldBeEqualOne() throws {
        // given
        service.expectedPostsResult = [.mock]
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.service.didFetchDataCallCount == 1)
            XCTAssertTrue(self?.service.didFetchDataCalled == true)
        }
    }
    
    func testFetchPosts_whenDataExist_statusShouldBeFetched() throws {
        // given
        service.expectedPostsResult = [.mock]
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertTrue(self?.sut.fetchingStatus == .fetched)
        }
    }
    
    func testFetchPosts_whenDataExist_bodyOfPostShouldBeAsExpected() throws {
        // given
        service.expectedPostsResult = [.mock]
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.postRowData(at: 0)?.body == "Body")
        }
    }
    
    func testFetchPosts_whenDataExist_numberOfPostsShouldBeOne() throws {
        // given
        service.expectedPostsResult = [.mock]
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.numberOfPosts() == 1)
        }
    }
    
    func testFetchPosts_whenDataDoesNotExist_statusShouldBeEmpty() throws {
        // given
        service.expectedPostsResult = []
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertTrue(self?.sut.fetchingStatus == .empty)
        }
    }
    
    func testFetchPosts_whenDataDoesNotExist_postRowDataShouldBeNil() throws {
        // given
        service.expectedPostsResult = []
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.postRowData(at: 0) == nil)
        }
    }
    func testFetchPosts_whenDataDoesNotExist_numberOfPostsShouldBeZero() throws {
        // given
        service.expectedPostsResult = []
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.numberOfPosts() == 0)
        }
    }
    
    func testFetchUsers_whenProblemWithFetchingExists_statusShouldBeError() throws {
        // given
        service.expectedPostsResult = []
        service.shouldFail = true
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            XCTAssertTrue(self?.sut.fetchingStatus == .error)
        }
    }
    
    func testFetchPosts_whenProblemWithFetchingExists_postRowDataShouldBeNil() throws {
        // given
        service.expectedPostsResult = []
        service.shouldFail = true
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.postRowData(at: 0) == nil)
        }
    }
    
    func testFetchPosts_whenProblemWithFetchingExists_numberOfPostsShouldBeZero() throws {
        // given
        service.expectedPostsResult = []
        service.shouldFail = true
        // when
        sut.fetchPosts()
        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            assert(self?.sut.numberOfPosts() == 0)
        }
    }
}
