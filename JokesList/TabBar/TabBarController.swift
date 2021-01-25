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
    private let jokesController = JokesViewController()
    private let apiController = ApiViewController()
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    //MARK: - Private methods:
    private func setupTabBar() {
        tabBar.tintColor = .black
        
        if #available(iOS 13.0, *) {
            viewControllers = [
                generateViewController(rootViewController: jokesController,
                                       image: UIImage(systemName: "1.circle"),
                                       title: "Jokes"),
                generateViewController(rootViewController: apiController,
                                       image: UIImage(systemName: "2.circle"),
                                       title: "Api")
            ]
        } else {
            viewControllers = [
                generateViewController(rootViewController: jokesController,
                                       title: "Jokes"),
                generateViewController(rootViewController: apiController,
                                       title: "Api")
            ]
        }
    }
    
    private func generateViewController(
        rootViewController: UIViewController,
        image: UIImage? = nil,
        title: String
    ) -> UIViewController {
        
        let navigationVC =
            UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.tintColor = .black
        return navigationVC
    }
}
