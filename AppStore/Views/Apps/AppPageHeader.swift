//
//  AppPageHeader.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppPageHeader: UICollectionReusableView {

  let appHeaderHorizontalController = AppsHeaderHorizontalController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    appHeaderHorizontalController.view.backgroundColor = .purple
    addSubview(appHeaderHorizontalController.view)
    appHeaderHorizontalController.view.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
