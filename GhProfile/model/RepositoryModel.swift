//
//  RepositoryModel.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

struct RepositoryModel {
    let name: String
    let description: String
    let starCount: Int
    let primaryLanguage: PrimaryLanguage
    
    static func createDefaultRepository() -> RepositoryModel {
        return RepositoryModel(name: "name", description: "description", starCount: 500,
                               primaryLanguage: PrimaryLanguage(name: "Swift", color: "#FFFFFF"))
    }
}

struct PrimaryLanguage {
    let name: String
    let color: String
}
