//
//  BaseListController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {

  // MARK: - Initialization

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
