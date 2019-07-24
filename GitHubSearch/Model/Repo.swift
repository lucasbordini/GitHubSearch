//
//  Repo.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

struct Repo {
    let id: Int
    let name: String
    let language: String?
    let forksCount: Int
    let createdDate: String
    let updatedDate: String
    let openIssues: Int
    let url: String
}

extension Repo: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case language = "language"
        case forksCount = "forks_count"
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case openIssues = "open_issues_count"
        case url = "html_url"
    }
}
