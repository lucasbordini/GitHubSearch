//
//  UserList.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserListViewController: ViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewModel = UserListViewModel(service: Injection.inject().userService)
    let segueIdentifier = "showDetails"
    var userList: [User]?
    var filter: Filter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBind()
    }
    
    private func setupBind() {
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel
            .isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                self.toggleLoad(show: isLoading)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .userList
            .observeOn(MainScheduler.instance)
            .subscribe({ userList in
                self.userList = userList.element
            })
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext : { err in
                let errorAlert = self.alert(message: "Something happened, verify your internet connection and try again", informative: false)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    self.viewModel.getUserList()
                    errorAlert.dismiss(animated: true, completion: nil)
                })
                errorAlert.addAction(retryAction)
                self.present(errorAlert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel
            .userList
            .bind(to: tableView.rx.items(cellIdentifier: UserListViewCell.reuseIdentifier)) { (index, user: User, cell: UserListViewCell) in
                cell.cellUser = user
                cell.selectionStyle = .none
            }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .skip(1)
            .debounce(RxTimeInterval(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { query in
                if query?.isEmpty == true {
                    self.viewModel.getUserList()
                } else {
                    self.viewModel.getUserByQuery(query: query)
                }
            }).disposed(by: disposeBag)
        
        tableView
            .rx
            .willDisplayCell
            .subscribe(onNext: { (cell, indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .transitionCurlUp, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                })
                
            }).disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(User.self)
            .subscribe(onNext: { [weak self] user in
                self?.performSegue(withIdentifier: "showDetails", sender: user)
            }).disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UserDetailsViewController, let user = sender as? User {
            vc.user = user
        } else if let vc = segue.destination as? FilterViewController {
            if let filter = self.filter {
                vc.previousFilter = filter
            }
            vc.filter
                .asObservable()
                .skip(1)
                .subscribe(onNext: { filter in
                self.filter = filter
                self.viewModel.getUserWithFilter(query: self.searchBar.text, filter: filter)
            }).disposed(by: disposeBag)
        }
    }
    
}
