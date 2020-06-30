//
//  BaseViewController.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var screenTitle: String?
    var navBarHeight: NSLayoutConstraint!
    @IBOutlet var baseView: UIView!
    var navigationBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.isHidden = true
        
        setupBaseView()
    }
    
    func setupBaseView() {
        
        if let customTitle = self.screenTitle {
            title = customTitle
        }
        self.view.addSubview(navigationBarView)
        navigationBarView.topAnchor.constraint(equalTo: baseView.layoutMarginsGuide.topAnchor).isActive = true
        navigationBarView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        navigationBarView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.navBarHeight = navigationBarView.heightAnchor.constraint(equalToConstant: 100)
        navBarHeight.isActive = true
    }
    
}

extension BaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//        if scrollView.contentOffset.y < 100 && self.navBarHeight.constant >= 0 {
//            self.navBarHeight.constant = self.navBarHeight.constant - scrollView.contentOffset.y
//            DispatchQueue.main.async {
//                self.view.layoutIfNeeded()
//            }
//        } else if self.navBarHeight.constant <= 100 {
//            self.navBarHeight.constant = self.navBarHeight.constant + scrollView.contentOffset.y
//            DispatchQueue.main.async {
//                self.view.layoutIfNeeded()
//            }
//        }
//
//        print("===>\(self.navBarHeight.constant)")
    }
}
