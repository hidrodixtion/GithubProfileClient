//
//  User.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

struct User: Codable {
    let avatarUrl: String
    let login: String
    let name: String
    let email: String
    let follower: Int
    let following: Int
    
    static func createDefaultUser() -> User {
        return User(avatarUrl: "http://avatar.com", login: "login", name: "name", email: "email", follower: 0, following: 0)
    }
}
