//
//  AboutViewController.swift
//  GitHubSearch
//
//  Created by mazzatech on 23/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit

class AboutViewController: ViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var aboutData: [CarouselData] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleLoad(show: true)
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = .linear
        carouselView.isPagingEnabled = true
        carouselView.isScrollEnabled = false
        setData()
    }
    
    func setData() {
        let userListInfo = CarouselData(title: "User List", description: "On this page you can see a list of github users, use the search bar on top to search by username")
        let filterListInfo = CarouselData(title: "Filter for User List", description: "On this page you can filter users by setting a minimun number of public repositories or followers, a minimun account creation date or selectectin a language they have worked with before")
        let detailsInfo = CarouselData(title: "User Details", description: "On this page you can see some details about the selected users and their repositories")
        aboutData.append(contentsOf: [userListInfo, filterListInfo, detailsInfo])
        carouselView.reloadData()
        nextButton.isHidden = aboutData.count == 1
        backButton.isHidden = true
        carouselView.isScrollEnabled = aboutData.count != 1
        carouselView.currentItemIndex = 0
        currentIndex = 0
        toggleLoad(show: false)
    }
    

}

extension AboutViewController: iCarouselDelegate, iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return aboutData.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 12, width: Constants.screenWidth - 46, height: 30)
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20)
        title.text = aboutData[index].title
        let description = UILabel()
        description.frame = CGRect(x: 0, y: 56, width: Constants.screenWidth - 62, height: 300)
        description.textAlignment = .center
        description.font = UIFont.systemFont(ofSize: 16)
        description.textColor = .darkGray
        description.numberOfLines = 5
        description.text = aboutData[index].description
        let container = UIView()
        container.frame = self.containerView.frame
        container.addSubview(title)
        container.addSubview(description)
        container.backgroundColor = .white
        container.toCard()
        return container
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }

    @IBAction func goNext(_ sender: Any) {
        self.carouselView.scroll(byNumberOfItems: 1, duration: 0.5)
        self.currentIndex += 1
        self.nextButton.isHidden = self.currentIndex == (self.aboutData.endIndex - 1)
        self.backButton.isHidden = self.currentIndex == self.aboutData.startIndex
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.carouselView.scroll(byNumberOfItems: -1, duration: 0.5)
        self.currentIndex -= 1
        self.backButton.isHidden = self.currentIndex == self.aboutData.startIndex
        self.nextButton.isHidden = self.currentIndex == (self.aboutData.endIndex - 1)
    }
    
    
}
