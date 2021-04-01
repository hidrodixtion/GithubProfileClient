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
                self.delegate?.onPinnedRepositoryFetched(list: list)
            } else {
                self.delegate?.onPinnedRepositoryFetched(list: [])
            }
        }
    }
    
    func fetchProfile() {
        repo.getLoginDetail { [unowned self] (user, error) in
            if let error = error {
                self.delegate?.onError(error: error)
                return
            }
            
            if let user = user {
                self.delegate?.onUserDataFetched(user: user)
            }
        }
    }
}

protocol ProfilePresenterDelegate {
    /// When data is fetched completely
    func onPinnedRepositoryFetched(list: [RepositoryModel])
    /// When user detail is fetched completely
    func onUserDataFetched(user: User)
    /// When there's error
    func onError(error: Error)
}
