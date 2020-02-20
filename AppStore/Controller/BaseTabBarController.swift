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
    viewControllers = [
      createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
      createNavController(viewController: AppSearchController(), title: "Search", imageName: "search"),
      createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
    ]
  }

  fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
    let navController = UINavigationController(rootViewController: viewController)
    viewController.navigationItem.title = title
    viewController.view.backgroundColor = .white
    navController.navigationBar.prefersLargeTitles = true
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    return navController
  }
}
