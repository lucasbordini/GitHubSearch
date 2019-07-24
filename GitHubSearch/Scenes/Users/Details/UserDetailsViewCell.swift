//
//  UserDetailsViewCell.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit

class UserDetailsViewCell: UITableViewCell {
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    static let identifier = "userDetails"
    
    
    public var repoCell: Repo! {
        didSet {
            languageImageView.image = LanguageImage.get(for: repoCell.language)
            repoName.text = repoCell.name
            languageLabel.text = repoCell.language ?? "-"
            forksCountLabel.text = repoCell.forksCount.toString
            openIssuesLabel.text = repoCell.openIssues.toString
            openIssuesLabel.textColor = repoCell.openIssues > 0 ? .red : .darkGray
            if let createdDate = DateFormatter.inValue.date(from: repoCell.createdDate) {
                createdDateLabel.text = DateFormatter.outValue.string(from: createdDate)
            } else {
                createdDateLabel.text = "-"
            }
            if let updatedDate = DateFormatter.inValue.date(from: repoCell.updatedDate) {
                updatedDateLabel.text = DateFormatter.outValue.string(from: updatedDate)
            } else {
                updatedDateLabel.text = "-"
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: [],animations: {
            self.contentView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        })
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 5, options: .curveEaseIn,animations: {
            self.contentView.backgroundColor = .clear
        })
        super.touchesEnded(touches, with: event)
    }
    
}
