//
//  ProfilePresenter.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class ProfilePresenter {
    private let repo: Repo!
    
    var delegate: ProfilePresenterDelegate?
    
    init(repo: Repo) {
        self.repo = repo
    }
    
    func fetchPinnedRepository() {
        repo.getPinnedRepository { [unowned self] (list, error) in
            if let error = error {
                self.delegate?.onError(error: error)
                return
            }
            
            if let list = list {
                self.delegate?.onDataFetched(list: list)
            } else {
                self.delegate?.onDataFetched(list: [])
            }
        }
    }
}

protocol ProfilePresenterDelegate {
    /// When data is fetched completely
    func onDataFetched(list: [RepositoryModel])
    /// When there's error
    func onError(error: Error)
}
