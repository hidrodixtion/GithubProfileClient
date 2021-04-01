//
//  ProfilePresenter.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

class ProfilePresenter {
    let repo: Repo!
    
    init(repo: Repo) {
        self.repo = repo
    }
    
    func fetchPinnedRepository() {
        repo.getPinnedRepository { (list, error) in
            
        }
    }
}
