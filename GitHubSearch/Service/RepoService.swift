//
//  RepoService.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol RepoService {
    func getRepoByUser(url: String) -> Observable<[Repo]>
}

class RepoServiceServer: RepoService {
    
    let session = Alamofire.Session()
    
    func getRepoByUser(url: String) -> Observable<[Repo]> {
        return Observable.create { observer in
            let url = URL(string: url)!
            self.session.request(url).responseDecodable(completionHandler: { (res: DataResponse<[Repo]>) in
                if let repoList = res.value {
                    observer.onNext(repoList)
                } else if let err = res.error {
                    observer.onError(err)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    
}
