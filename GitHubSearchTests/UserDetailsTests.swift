//
//  UserDetailsTests.swift
//  GitHubSearchTests
//
//  Created by mazzatech on 23/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import XCTest
import RxSwift

@testable import GitHubSearch

class UserDetailsTests: XCTestCase {
    
    let viewModel = UserDetailsViewModel(userService: Injection.inject().userService, repoService: Injection.inject().repoService)
    let disposeBag = DisposeBag()

    override func setUp() {}

    override func tearDown() {}
    
    func testIfGetInfoReturnUserData() {
        self.viewModel.user.asObserver().subscribe(onNext: { user in
            XCTAssertNotNil(user)
        }).disposed(by: disposeBag)
        viewModel.getUserDetails(userURL: "github.com/steve")
    }
    
    func testIfGetInfoReturnRepo() {
        self.viewModel.repoList.asObserver().subscribe(onNext: { repo in
            XCTAssertFalse(repo.isEmpty)
        }).disposed(by: disposeBag)
        viewModel.getUserDetails(userURL: "github.com/bill")
    }
    
    func testIfIGetErrorWithWrongURL() {
        self.viewModel.error.asObserver().subscribe(onNext: { err in
            XCTAssertNotNil(err)
        }).disposed(by: disposeBag)
        viewModel.getUserDetails(userURL: "notALink")
    }
    
    func testFunctionForGetMostFrequent() {
        let arr = [1, 2, 3, 1, 4, 1, 5, 1, 4, 7]
        XCTAssertEqual(self.viewModel.mostFrequent(array: arr), 1)
        let str = ["a", "b", "c", "a", "d", "a"]
        XCTAssertEqual(self.viewModel.mostFrequent(array: str), "a")
    }

}
