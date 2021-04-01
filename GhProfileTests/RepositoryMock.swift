//
//  RepositoryMock.swift
//  GhProfileTests
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation
@testable import GhProfile

class SuccessRepositoryMock: Repo {
    static let repos = [RepositoryModel.createDefaultRepository(), RepositoryModel.createDefaultRepository()]
    
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void) {
        callback(SuccessRepositoryMock.repos, nil)
    }
    
    func getLoginDetail(callback: @escaping (User?, Error?) -> Void) {
        callback(User.createDefaultUser(), nil)
    }
}

class FailedRepositoryMock: Repo {
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void) {
        callback(nil, RequestError.noData)
    }
    
    func getLoginDetail(callback: @escaping (User?, Error?) -> Void) {
        callback(nil, RequestError.noData)
    }
}
