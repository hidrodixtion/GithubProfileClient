//
//  LocalRepo.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation
import Shallows

class LocalRepo: Repo {
    private let kPinnedRepository = "kPinnedRepository"
    private let kProfile = "kProfile"
    
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void) {
        let diskStorage = DiskStorage.main.folder("pinnedRepository", in: .cachesDirectory)
            .mapJSONObject([RepositoryModel].self)
        
        diskStorage.retrieve(forKey: .init(stringLiteral: kPinnedRepository)) { (result) in
            switch result {
            case .success(let list):
                callback(list, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    
    func getLoginDetail(callback: @escaping (User?, Error?) -> Void) {
        let diskStorage = DiskStorage.main.folder("profile", in: .cachesDirectory)
            .mapJSONObject(User.self)
        
        diskStorage.retrieve(forKey: .init(stringLiteral: kProfile)) { (result) in
            switch result {
            case .success(let user):
                callback(user, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    
    func savePinnedRepositories(list: [RepositoryModel]) {
        let diskStorage = DiskStorage.main.folder("pinnedRepository", in: .cachesDirectory)
            .mapJSONObject([RepositoryModel].self)
        
        diskStorage.set(list, forKey: .init(stringLiteral: kPinnedRepository))
        
        RepoUtil.saveLastFetched(key: RepoUtil.kLastFetchedPinnedRepo, date: Date())
    }
    
    func saveLoginDetail(user: User) {
        let diskStorage = DiskStorage.main.folder("profile", in: .cachesDirectory)
            .mapJSONObject(User.self)
        
        diskStorage.set(user, forKey: .init(stringLiteral: kProfile))
    }
}
