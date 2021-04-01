//
//  GhProfileTests.swift
//  GhProfileTests
//
//  Created by Adi Nugroho on 01/04/21.
//

import XCTest
@testable import GhProfile

class ProfilePresenterTests: XCTestCase, ProfilePresenterDelegate {
    
    var successProfilePresenter: ProfilePresenter!
    var failedProfilePresenter: ProfilePresenter!
    
    var expectation: XCTestExpectation?
    var pinnedRepositories: [RepositoryModel]?
    var profile: User?

    override func setUpWithError() throws {
        successProfilePresenter = ProfilePresenter(repo: SuccessRepositoryMock())
        failedProfilePresenter = ProfilePresenter(repo: FailedRepositoryMock())
        
        successProfilePresenter.delegate = self
        failedProfilePresenter.delegate = self
    }

    override func tearDownWithError() throws {
        expectation = nil
        pinnedRepositories = nil
        profile = nil
    }

    func testFetchPinnedRepositoryShouldReturnSuccess() throws {
        expectation = expectation(description: "fetch pinned")
        successProfilePresenter.fetchPinnedRepository()
        
        waitForExpectations(timeout: 1)
        
        let result = try XCTUnwrap(pinnedRepositories)
        XCTAssertEqual(result.count, SuccessRepositoryMock.repos.count)
    }
    
    func testFetchPinnedRepositoryShouldFailed() throws {
        expectation = expectation(description: "fetch pinned")
        failedProfilePresenter.fetchPinnedRepository()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(pinnedRepositories)
    }
    
    func testFetchUserShouldReturnSuccess() throws {
        expectation = expectation(description: "fetch user")
        successProfilePresenter.fetchProfile()
        
        waitForExpectations(timeout: 1)
        
        let result = try XCTUnwrap(profile)
        XCTAssertEqual(result.name, User.createDefaultUser().name)
    }
    
    func testFetchUserShouldFailed() throws {
        expectation = expectation(description: "fetch user")
        failedProfilePresenter.fetchProfile()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(profile)
    }
    
    //MARK: Delegate Methods
    func onPinnedRepositoryFetched(list: [RepositoryModel]) {
        pinnedRepositories = list
        expectation?.fulfill()
    }
    
    func onUserDataFetched(user: User) {
        profile = user
        expectation?.fulfill()
    }
    
    func onError(error: Error) {
        expectation?.fulfill()
    }
}
