//
//  AppSearchController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/12.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .red
  }

  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
