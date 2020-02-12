//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/12.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let redViewController = UIViewController()
    redViewController.view.backgroundColor = .white
    redViewController.navigationItem.title = "Apps"
    let redNavController = UINavigationController(rootViewController: redViewController)
    redNavController.tabBarItem.title = "Apps"
    redNavController.tabBarItem.image = UIImage(named: "apps")
    redNavController.navigationBar.prefersLargeTitles = true

    let blueViewController = UIViewController()
    blueViewController.view.backgroundColor = .white
    blueViewController.navigationItem.title = "Search"
    let blueNavController = UINavigationController(rootViewController: blueViewController)
    blueNavController.tabBarItem.title = "Search"
    blueNavController.tabBarItem.image = UIImage(named: "search")
    blueNavController.navigationBar.prefersLargeTitles = true

    viewControllers = [
      redNavController,
      blueNavController
    ]
  }
}
