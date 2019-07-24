//
//  UserDetail.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

struct UserDetail {
    let id: Int
    let login: String
    let avatar: String
    let reposList: String
    let followers: Int
    let following: Int
    var mainLanguage: String?
}

extension UserDetail: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatar = "avatar_url"
        case reposList = "repos_url"
        case followers = "followers"
        case following = "following"
    }
}
