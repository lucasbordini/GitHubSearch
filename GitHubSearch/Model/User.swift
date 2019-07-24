//
//  User.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let login: String
    let avatar: String
    let url: String
}

extension User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatar = "avatar_url"
        case url = "url"
    }
}

