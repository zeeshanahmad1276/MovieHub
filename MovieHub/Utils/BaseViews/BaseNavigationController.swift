//
//  BaseNavigationController.swift
//  MovieHub
//
//  Created by Macbook 5 on 8/3/23.
//

import UIKit

class BaseNavigationController:UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initBar()
    }
    
    func initBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = .appDark
        navigationBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.fixelText(size: 26, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.fixelText(size: 18, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }
  
  
}



