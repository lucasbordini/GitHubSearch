//
//  UserDetailsViewModel.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift

class UserDetailsViewModel: ViewModel {
    
    let user = PublishSubject<UserDetail>()
    let isLoading = PublishSubject<Bool>()
    let error = PublishSubject<Error>()
    let repoList = PublishSubject<[Repo]>()
    
    private let userService: UserService
    private let repoService: RepoService
    
    init(userService: UserService, repoService: RepoService) {
        self.userService = userService
        self.repoService = repoService
        super.init()
    }
    
    
    func getUserDetails(userURL: String) {
        isLoading.onNext(true)
        userService
            .getUser(userURL: userURL)
            .flatMap({ (user: UserDetail) -> Observable<[Repo]> in
                return self.repoService.getRepoByUser(url: user.reposList)
                    .map({ repos in
                        let langagues = repos.compactMap({ $0.language })
                        var user = user
                        user.mainLanguage = self.mostFrequent(array: langagues)
                        self.user.onNext(user)
                        return repos
                    })
            }).subscribe(onNext: { (repoList: [Repo]) in
                self.repoList.onNext(repoList)
                self.isLoading.onNext(false)
            }, onError: { err in
                self.error.onNext(err)
                self.isLoading.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    func mostFrequent<T: Hashable>(array: [T]) -> T? {
        let counts = array.reduce(into: [:]) { $0[$1, default: 0] += 1 }
        if let value = counts.max(by: { $0.1 < $1.1 })?.key {
            return value
        }
        return nil
    }
    
}
