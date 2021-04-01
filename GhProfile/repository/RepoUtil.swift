//
//  RepoUtil.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class RepoUtil {
    static let kLastFetchedPinnedRepo = "kLastFetchedPinnedRepo"
    
    static func saveLastFetched(key: String, date: Date) {
        UserDefaults.standard.set(date.timeIntervalSince1970, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func retrieveLastFetched(key: String) -> Date {
        let milis = UserDefaults.standard.double(forKey: kLastFetchedPinnedRepo)
        let date = Date(timeIntervalSince1970: milis)
        return date
    }
}
