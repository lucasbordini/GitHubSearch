//
//  UserListViewModel.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift

class UserListViewModel: ViewModel {
    
    public let userList = PublishSubject<[User]>()
    public let isLoading = PublishSubject<Bool>()
    public let error = PublishSubject<Error>()
    
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
        super.init()
        self.getUserList()
    }
    
    
    func getUserList() {
        self.isLoading.onNext(true)
        self.service
            .getUserList()
            .subscribe(onNext: { userList in
                self.userList.onNext(userList)
                self.isLoading.onNext(false)
            }, onError: { err in
                self.error.onNext(err)
                self.isLoading.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    func getUserByQuery(query: String?) {
        self.isLoading.onNext(true)
        self.service
            .getUserByQuery(query: query)
            .subscribe(onNext: { userList in
                self.userList.onNext(userList.items)
                self.isLoading.onNext(false)
            }, onError: { err in
                self.error.onNext(err)
                self.isLoading.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    func getUserWithFilter(query: String?, filter: Filter){
        self.isLoading.onNext(true)
        self.service
            .getUserWithFilter(query: query, filter: filter)
            .subscribe(onNext: { userList in
                self.userList.onNext(userList)
                self.isLoading.onNext(false)
            }, onError: { err in
                self.error.onNext(err)
                self.isLoading.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    
    
    
}
