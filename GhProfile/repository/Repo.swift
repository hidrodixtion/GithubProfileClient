//
//  Repository.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation
import Apollo

protocol Repo {
    func getPinnedRepository(callback: @escaping ([GetPinnedRepositoriesQuery.Data.User.PinnedItem.Node.AsRepository?]?, Error?) -> Void)
}
