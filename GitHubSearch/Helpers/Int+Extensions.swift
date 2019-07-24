//
//  Int+Extensions.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation


extension Int {
    var toString: String {
        return String(self)
    }
}

extension Optional where Wrapped == Int {
    var toString: String {
        if let welf = self {
            return String(welf)
        }
        return ""
    }
}
