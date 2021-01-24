//
//  TabBarController.swift
//  JokesList
//
//  Created by Артём Устинов on 24.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Private properties:
    private let jokesVC = JokesViewController()
    private let apiVC = ApiViewController()
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    //MARK: - Private methods:
    private func setupTabBar() {
        tabBar.tintColor = .black
        
        viewControllers = [
            generateViewController(rootViewController: jokesVC,
                                   image: UIImage(systemName: "1.circle"),
                                   title: "Jokes"),
            generateViewController(rootViewController: apiVC,
                                   image: UIImage(systemName: "2.circle"),
                                   title: "Api")
        ]
        
        //! Разобраться с ИОС10 - систем нейма к примеру там нету! 
    }
    
    private func generateViewController(
        rootViewController: UIViewController,
        image: UIImage?,
        title: String
    ) -> UIViewController {
        
        let navigationVC =
            UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        return navigationVC
    }
}
