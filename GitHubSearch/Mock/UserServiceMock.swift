//
//  UserServiceMock.swift
//  GitHubSearch
//
//  Created by mazzatech on 23/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift

class UserServiceMock: UserService {
    
    let linus = User(id: 1, login: "Linus Torvalds", avatar: "https://s3.amazonaws.com/talkstar-photos/uploads/f69760c8-2dea-43ce-9594-f02ca4175946/LinusTorvalds_2016-embed.jpg", url: "github.com/linus")
    
    let bill = User(id: 2, login: "Bill Gates", avatar: "https://abrilexame.files.wordpress.com/2019/04/bill.jpg", url: "github.com/bill")
    
    let steve = User(id: 3, login: "Steve Jobs", avatar: "https://image.cnbcfm.com/api/v1/image/100496736-steve-jobs-march-2011-getty.jpg?v=1513863842&w=1400&h=950", url: "github.com/steve")
    
    let mark = User(id: 4, login: "Mark Zuckerberg", avatar: "https://abrilveja.files.wordpress.com/2018/07/tecnologia-mark-zuckerberg-20180726-0002.jpg", url: "github.com/mark")
    
    let larry = User(id: 5, login: "Larry Page", avatar: "https://amp.businessinsider.com/images/5b748ea80ce5f519008b55fa-750-562.jpg", url: "github.com/larry")
    
    
    func getUserList() -> Observable<[User]> {
        let arr = [linus, bill, steve, mark, larry]
        return Observable.just(arr)
        
    }
    
    func getUserByQuery(query: String?) -> Observable<SearchUser> {
        let arr = [linus, bill, steve, mark, larry]
        if let query = query {
            let filtered = arr.filter({ $0.login.lowercased().contains(query.lowercased())})
            let searchUser = SearchUser(totalCount: filtered.count, incompleteResults: false, items: filtered)
            return Observable.just(searchUser)
        }
        let searchUser = SearchUser(totalCount: arr.count, incompleteResults: false, items: arr)
        return Observable.just(searchUser)
    }
    
    func getUser(userURL: String) -> Observable<UserDetail> {
        let arr = [linus, bill, steve, mark, larry]
        if let user = arr.first(where: { $0.url == userURL }) {
            let userDetails = UserDetail(id: user.id, login: user.login, avatar: user.avatar, reposList: user.url, followers: 10, following: 10, mainLanguage: "C")
            return Observable.just(userDetails)
        }
        return Observable<UserDetail>.error(MockError.empty("Empty"))
    }
    
    func getUserWithFilter(query: String?, filter: Filter) -> Observable<[User]> {
        var filteredUsers: [User] = []
        if let query = query, query != "" {
            filteredUsers.append(linus)
        }
        if let repos = filter.repoNumber, repos != "" {
            filteredUsers.append(bill)
        }
        if let followers = filter.followerNumber, followers != "" {
            filteredUsers.append(steve)
        }
        if let date = filter.createdDate, date != "" {
            filteredUsers.append(mark)
        }
        if let language = filter.language, language != "" {
            filteredUsers.append(larry)
        }
        if filteredUsers.isEmpty {
            filteredUsers = [linus, bill, steve, mark, larry]
        }
        return Observable.just(filteredUsers)
    }
    
    
}

enum MockError: Error {
    case empty(String)
}
