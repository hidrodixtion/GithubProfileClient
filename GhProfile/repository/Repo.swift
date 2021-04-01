//
//  Repository.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation
import Apollo

protocol Repo {
    /// Get Pinned Repository from user: Sindresorhus
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void)
    
    /// Get login detail
    func getLoginDetail(callback: @escaping (User?, Error?) -> Void)
}
