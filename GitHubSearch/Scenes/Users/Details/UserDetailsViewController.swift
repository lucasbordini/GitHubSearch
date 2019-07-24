//
//  UserDetailsViewController.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class UserDetailsViewController: ViewController {
    
    //Cards
    @IBOutlet weak var headerCardView: UIView!
    @IBOutlet weak var tableCardView: UIView!
    //Header
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mainLanguageLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    //Table
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = UserDetailsViewModel(userService: Injection.inject().userService, repoService: Injection.inject().repoService)
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            self.toggleLoad(show: true)
            viewModel.getUserDetails(userURL: user.url)
            self.setupBind()
        }
    }
    
    private func setupBind() {
        
        viewModel
            .user
            .observeOn(MainScheduler.instance)
            .subscribe({ user in
                self.setupLayout(with: user.element)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .repoList
            .bind(to: tableView.rx.items(cellIdentifier: UserDetailsViewCell.identifier)) { (index, repo: Repo, cell: UserDetailsViewCell) in
                cell.repoCell = repo
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
        
        viewModel
            .isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isloading in
                self.toggleLoad(show: isloading)
                
            })
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { err in
                let errorAlert = self.alert(message: "Something happened, verify your internet connection and try again", informative: false)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    if let url = self.user?.url {
                        self.viewModel.getUserDetails(userURL: url)
                    }
                    errorAlert.dismiss(animated: true, completion: nil)
                })
                errorAlert.addAction(retryAction)
                self.present(errorAlert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Repo.self)
            .observeOn(MainScheduler.instance)
            .subscribe({ repo in
                if let urlString = repo.element?.url, let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }).disposed(by: disposeBag)
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    
    private func setupLayout(with user: UserDetail?) {
        guard let user = user else { return }
        self.headerCardView.toCard()
        self.tableCardView.toCard()
        self.avatarImageView.setImage(with: URL(string: user.avatar))
        self.usernameLabel.text = user.login
        self.mainLanguageLabel.text = user.mainLanguage ?? "-"
        self.followersLabel.text = user.followers.toString
        self.followingLabel.text = user.following.toString
    }
    
    
}
