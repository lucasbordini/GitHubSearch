//
//  Injection.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation

class Injection {
    
    static func inject() -> InjectionProtocol {
        #if MOCK
        return Mock()
        #else
        return Server()
        #endif
    }
}

class Server: InjectionProtocol {
    
    var userService: UserService
    var repoService: RepoService
    
    init() {
        self.userService = UserServiceServer()
        self.repoService = RepoServiceServer()
    }
    
}

class Mock: InjectionProtocol {
    
    var userService: UserService
    var repoService: RepoService
    
    init() {
        self.userService = UserServiceMock()
        self.repoService = RepoServiceMock()
    }
}

protocol InjectionProtocol {
    
    var userService: UserService { get }
    var repoService: RepoService { get }

}
