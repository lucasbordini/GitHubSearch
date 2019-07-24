//
//  ViewModel.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var disposeBag: DisposeBag { get set }
    func destroy()
}

class ViewModel: BaseViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()

    func destroy() {
    }
}
