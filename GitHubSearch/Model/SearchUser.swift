//
//  SearchUser.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

struct SearchUser {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]
}

extension SearchUser: Codable {
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}
