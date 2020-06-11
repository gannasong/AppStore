//
//  BackEnableNavigationController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/26.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class BackEnableNavigationController: UINavigationController, UIGestureRecognizerDelegate {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.interactivePopGestureRecognizer?.delegate = self
  }

  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.viewControllers.count > 1
  }
}
