//
//  UserListTests.swift
//  GitHubSearchTests
//
//  Created by mazzatech on 23/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import XCTest
import RxSwift

@testable import GitHubSearch

class UserListTests: XCTestCase {

    let viewModel = UserListViewModel(service: Injection.inject().userService)
    let disposeBag = DisposeBag()

    override func setUp() {}

    override func tearDown() {}

    func testIfListIsLoading() {
        viewModel.userList.asObservable().subscribe(onNext: { list in
            XCTAssertFalse(list.isEmpty)
        }).disposed(by: disposeBag)
        viewModel.getUserList()
    }

    func testIfQueryIsWorking() {
        viewModel.userList.asObservable().subscribe(onNext: { list in
            XCTAssertFalse(list.isEmpty)
        }).disposed(by: disposeBag)
        viewModel.getUserByQuery(query: "steve")
    }

    func testIfWrongQueryIsWorking() {
        viewModel.userList.asObservable().subscribe(onNext: { list in
            XCTAssertTrue(list.isEmpty)
        }).disposed(by: disposeBag)
        viewModel.getUserByQuery(query: "*******")
    }

    func testIfFilterIsWorking() {
        viewModel.userList.asObservable().subscribe(onNext: { list in
            XCTAssertFalse(list.isEmpty)
        }).disposed(by: disposeBag)
        let filter = Filter(repoNumber: nil, followerNumber: "100", createdDate: nil, language: nil)
        viewModel.getUserWithFilter(query: nil, filter: filter)
    }

}
