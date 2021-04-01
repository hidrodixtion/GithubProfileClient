//
//  RemoteRepository.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class RemoteRepo: Repo {
    func getPinnedRepository(callback: @escaping ([RepositoryModel]?, Error?) -> Void) {
        Service.shared.apollo.fetch(query: GetPinnedRepositoriesQuery()) { (response) in
            switch response {
            case .success(let result):
                if let nodes = result.data?.user?.pinnedItems.nodes {
                    let list = nodes.compactMap({ $0 }).filter({ $0.asRepository != nil }).map { (item) -> RepositoryModel in
                        let toRepo = item.asRepository!
                        let primaryLanguage = toRepo.primaryLanguage
                        return RepositoryModel(name: toRepo.name, description: toRepo.description ?? "", starCount: toRepo.stargazerCount,
                                               primaryLanguage: PrimaryLanguage(name: primaryLanguage?.name ?? "",
                                                                                color: primaryLanguage?.color ?? "#FFFFFF"))
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
