//
//  WhiteSearchBar.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit

class WhiteSearchBar: UISearchBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundImage = UIImage()
    }
}
