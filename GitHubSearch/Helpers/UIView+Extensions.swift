//
//  UIView+Extensions.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit

extension UIView {
    
    func toCard() {
//        self.clipsToBounds = true
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 1
    }
}
