//
//  Filter.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

struct Filter {
    let repoNumber: String?
    let followerNumber: String?
    let createdDate: String?
    let language: String?
    
    init() {
        self.repoNumber = nil
        self.followerNumber = nil
        self.createdDate = nil
        self.language = nil
    }
    
    init(repoNumber: String?, followerNumber: String?, createdDate: String?, language: String?){
        self.repoNumber = repoNumber
        self.followerNumber = followerNumber
        self.createdDate = createdDate
        self.language = language
    }
}
