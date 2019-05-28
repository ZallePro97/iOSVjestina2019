//
//  TabBarControllerViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 28/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navController = UINavigationController()
        let quizzListVC = QuizzListTableViewController()
        navController.addChild(quizzListVC)
        
        quizzListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        
        let tabBarList = [navController]
        
        viewControllers = tabBarList
    }
    

    

}
