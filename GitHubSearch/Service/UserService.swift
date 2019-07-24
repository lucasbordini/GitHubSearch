//
//  UserService.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol UserService {
    func getUserList() -> Observable<[User]>
    func getUserByQuery(query: String?) -> Observable<SearchUser>
    func getUser(userURL: String) -> Observable<UserDetail>
    func getUserWithFilter(query: String?, filter: Filter) -> Observable<[User]>
}

class UserServiceServer: UserService {
    
    let session = Alamofire.Session()
    
    func getUserList() -> Observable<[User]> {
        return Observable.create { observer in
            let url = Constants.baseURL.appending("users")
            self.session.request(URL(string: url)!).responseDecodable(completionHandler: { (res: DataResponse<[User]>) in
                if let userList = res.value {
                    observer.onNext(userList)
                } else if let err = res.error {
                    observer.onError(err)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getUserByQuery(query: String?) -> Observable<SearchUser> {
        return Observable.create { observer in
            var url = Constants.baseURL
            if let query = query {
                url = url.appending("search/users?q=\(query)")
            } else {
                url = url.appending("users")
            }
            url = url.replacingOccurrences(of: " ", with: "")
            self.session.request(URL(string: url)!).responseDecodable(completionHandler: { (res: DataResponse<SearchUser>) in
                if let userList = res.value {
                    observer.onNext(userList)
                } else if let err = res.error {
                    observer.onError(err)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getUser(userURL: String) -> Observable<UserDetail> {
        return Observable.create { observer in
            let url = URL(string: userURL)!
            self.session.request(url).responseDecodable(completionHandler: { (res: DataResponse<UserDetail>) in
                if let user = res.value {
                    observer.onNext(user)
                } else if let err = res.error {
                    observer.onError(err)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func getUserWithFilter(query: String?, filter: Filter) -> Observable<[User]> {
        var queryString: String? = nil
        var repoNumber: String? = nil
        var followerNumber: String? = nil
        var createdDate: String? = nil
        var language: String? = nil
        var url = Constants.baseURL.appending("search/users?q=")
        if query != nil && query?.isEmpty == false {
            queryString = query
        }
        if filter.repoNumber != nil && filter.repoNumber?.isEmpty == false {
            repoNumber = filter.repoNumber
        }
        if filter.followerNumber != nil && filter.followerNumber?.isEmpty == false {
            followerNumber = filter.followerNumber
        }
        if filter.createdDate != nil && filter.createdDate?.isEmpty == false {
            createdDate = filter.createdDate
        }
        if filter.language != nil && filter.language?.isEmpty == false {
            language = filter.language
        }
        var isFirst = true
        if let string = queryString{
            url = url.appending(string)
            isFirst = false
        }
        if let string = repoNumber {
            url = isFirst ? url.appending("repos:>\(string)") : url.appending("+repos:>\(string)")
            isFirst = false
        }
        if let string = followerNumber {
            url = isFirst ? url.appending("followers:>\(string)") : url.appending("+followers:>\(string)")
            isFirst = false
        }
        if let string = createdDate {
            url = isFirst ? url.appending("created:>\(string)") : url.appending("+created:>\(string)")
            isFirst = false
        }
        if let string = language {
            url = isFirst ? url.appending("language:>\(string)") : url.appending("+language:>\(string)")
            isFirst = false
        }
        if isFirst {
            return self.getUserList()
        }
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return Observable.create { observer in
            self.session.request(URL(string: url)!).responseDecodable(completionHandler: { (res: DataResponse<SearchUser>) in
                if let userList = res.value {
                    observer.onNext(userList.items)
                } else if let err = res.error {
                    observer.onError(err)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}
