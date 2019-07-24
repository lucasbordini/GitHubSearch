//
//  RepoServiceMock.swift
//  GitHubSearch
//
//  Created by mazzatech on 23/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift

class RepoServiceMock: RepoService {
    
    func getRepoByUser(url: String) -> Observable<[Repo]> {
        switch url {
        case "github.com/linus":
            let linux = Repo(id: 1, name: "Linux", language: "C", forksCount: 100000, createdDate: "", updatedDate: "", openIssues: 300, url: "https://linux.com")
            let git = Repo(id: 2, name: "Git", language: "Python", forksCount: 2000, createdDate: "", updatedDate: "", openIssues: 0, url: "https://git-scm.com/")
            return Observable.just([linux, git])
        case "github.com/bill":
            let windows = Repo(id: 3, name: "Windows", language: "C#", forksCount: 20, createdDate: "", updatedDate: "", openIssues: 999, url: "https://www.microsoft.com/pt-br/windows/")
            let vsCode = Repo(id: 4, name: "Visual Studio Code", language: "JavaScript", forksCount: 8000, createdDate: "", updatedDate: "", openIssues: 0, url: "https://code.visualstudio.com/")
            return Observable.just([windows, vsCode])
        case "github.com/steve":
            let macOS = Repo(id: 5, name: "macOS", language: "Objective-C", forksCount: 999, createdDate: "", updatedDate: "", openIssues: 3, url: "https://www.apple.com/br/macos")
            let iOS = Repo(id: 6, name: "iOS", language: "Swift", forksCount: 888, createdDate: "", updatedDate: "", openIssues: 0, url: "https://www.apple.com/br/ios")
            return Observable.just([macOS, iOS])
        case "github.com/mark":
            let facebook = Repo(id: 7, name: "Facebook", language: "PHP", forksCount: 333, createdDate: "", updatedDate: "", openIssues: 487, url: "https://facebook.com")
            let instagram = Repo(id: 8, name: "Instagram", language: "TypeScript", forksCount: 3321, createdDate: "", updatedDate: "", openIssues: 0, url: "https://instagram.com")
            return Observable.just([facebook, instagram])
        case "github.com/larry":
            let google = Repo(id: 9, name: "Google", language: "Ruby", forksCount: 22, createdDate: "", updatedDate: "", openIssues: 3231, url: "https://google.com")
            let android = Repo(id: 10, name: "Android", language: "Java", forksCount: 321, createdDate: "", updatedDate: "", openIssues: 0, url: "https://android.com")
            return Observable.just([google, android])
        default:
            return Observable.just([])
        }
    }
    
    
}
