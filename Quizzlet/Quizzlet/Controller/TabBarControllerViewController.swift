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
        
        quizzListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        quizzListVC.tabBarItem.title = "Quizzess"
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        settingsVC.tabBarItem.title = "Settings"
        
        let tabBarList = [navController, settingsVC]
        
        viewControllers = tabBarList
    }
    

    

}
