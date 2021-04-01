//
//  AppRepository.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class AppRepository: Repo {
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void) {
        let lastFetchedDifference = getMinuteDiff()
        
        if lastFetchedDifference >= 60 {
            RemoteRepo().getPinnedRepository(callback: callback)
        } else {
            LocalRepo().getPinnedRepository(callback: callback)
        }
    }
    
    func getLoginDetail(callback: @escaping (User?, Error?) -> Void) {
        let lastFetchedDifference = getMinuteDiff()
        
        if lastFetchedDifference >= 60 {
            RemoteRepo().getLoginDetail(callback: callback)
        } else {
            LocalRepo().getLoginDetail(callback: callback)
        }
    }
    
    private func getMinuteDiff() -> Int {
        let lastFetched = RepoUtil.retrieveLastFetched(key: RepoUtil.kLastFetchedPinnedRepo)
        let diffComponents = Calendar.current.dateComponents([.minute], from: lastFetched, to: Date())
        
        return diffComponents.minute ?? 60
    }
}
