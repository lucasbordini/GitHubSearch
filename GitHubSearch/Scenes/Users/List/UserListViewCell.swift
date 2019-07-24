//
//  UserListViewCell.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit
import MapleBacon

class UserListViewCell: UITableViewCell {
    
    static let reuseIdentifier = "userListCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    public var cellUser: User! {
        didSet {
            self.profileImageView.setImage(with: URL(string: cellUser.avatar))
            self.profileImageView.clipsToBounds = true
            self.profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            self.usernameLabel.text = cellUser.login
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardView.toCard()
    }
    
    override func prepareForReuse() {
        self.profileImageView.image = UIImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [],animations: {
            self.cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
        super.touchesBegan(touches, with: event)
    }
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: .curveEaseIn,animations: {
            self.cardView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        super.touchesEnded(touches, with: event)
    }
    
    
}
