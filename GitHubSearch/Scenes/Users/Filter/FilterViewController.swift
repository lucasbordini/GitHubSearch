//
//  FilterViewController.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FilterViewController: ViewController {
    
    @IBOutlet weak var repoNumberTextField: UITextField!
    @IBOutlet weak var followerNumberTextField: UITextField!
    @IBOutlet weak var accountCreatedTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    
    
    let languageOptions = ["C", "C#", "ActionScript", "Clojure", "CSS", "CoffeeScript", "Go", "Haskell", "HTML", "Java", "JavaScript", "Lua", "MATLAB", "Objective-C", "Perl", "PHP", "Python", "R", "Ruby", "Scala", "Shell", "Swift"]
    
    public let filter = BehaviorRelay<Filter>(value: Filter())
    public var previousFilter: Filter? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageTextField.loadDropdown(data: languageOptions)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        accountCreatedTextField.inputView = datePicker
        repoNumberTextField.text = previousFilter?.repoNumber
        followerNumberTextField.text = previousFilter?.followerNumber
        languageTextField.text = previousFilter?.language
        accountCreatedTextField.text = previousFilter?.createdDate
    }
    
    
    @IBAction func applyFilter(_ sender: Any) {
        let repoNumber = repoNumberTextField.text
        let followerNumber = followerNumberTextField.text
        let language = languageTextField.text
        let date = accountCreatedTextField.text
        let newFilter = Filter(repoNumber: repoNumber, followerNumber: followerNumber, createdDate: date, language: language)
        self.filter.accept(newFilter)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetFilter(_ sender: Any) {
        repoNumberTextField.text = ""
        followerNumberTextField.text = ""
        languageTextField.text = ""
        accountCreatedTextField.text = ""
    }
    
  
    @IBAction func closeFilter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateSelected() {
        guard let picker = accountCreatedTextField.inputView as? UIDatePicker else { return }
        let date = DateFormatter.searchValue.string(from: picker.date)
        self.accountCreatedTextField.text = date
    }
    
    
}

