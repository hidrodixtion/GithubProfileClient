//
//  RemoteRepository.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class RemoteRepo: Repo {
    func getPinnedRepository(callback: @escaping ([GetPinnedRepositoriesQuery.Data.User.PinnedItem.Node.AsRepository?]?, Error?) -> Void) {
        Service.shared.apollo.fetch(query: GetPinnedRepositoriesQuery()) { (response) in
            switch response {
            case .success(let result):
                if let nodes = result.data?.user?.pinnedItems.nodes {
                    let list = nodes.compactMap({ $0 }).map { (node)in
                        return node.asRepository
                    }
                    
                    callback(list, nil)
                } else {
                    callback(nil, RequestError.noData)
                }
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
}
