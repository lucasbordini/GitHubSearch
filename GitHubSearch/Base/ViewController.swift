//
//  View.swift
//  GitHubSearch
//
//  Created by mazzatech on 21/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseViewController {
    var disposeBag: DisposeBag { get set }
    func alert(message: String, informative: Bool) -> UIAlertController
    func toggleLoad(show: Bool)
}

class ViewController: UIViewController, BaseViewController {
    
    var disposeBag: DisposeBag = DisposeBag()

    func alert(message: String, informative: Bool = true) -> UIAlertController {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        if informative {
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
        }
        return alert
    }
    
    func toggleLoad(show: Bool) {
        if (show) {
            let translucentView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight))
            translucentView.backgroundColor = UIColor.white
            let requestIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            requestIndicator.color = UIColor.black
            requestIndicator.center = self.view.center
            translucentView.addSubview(requestIndicator)
            requestIndicator.startAnimating()
            translucentView.tag = Constants.ScreenTags.loadingScreen.rawValue
            self.view.addSubview(translucentView)
        } else {
            self.view.viewWithTag(Constants.ScreenTags.loadingScreen.rawValue)?.removeFromSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        disposableBag.
    }
    
    
}
