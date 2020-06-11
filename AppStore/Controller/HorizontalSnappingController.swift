//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {

  init() {
    let layout = BetterSnappingLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)

    // 使用 .fast 可以讓 targetContentOffset 速度加快
    collectionView.decelerationRate = .fast
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
