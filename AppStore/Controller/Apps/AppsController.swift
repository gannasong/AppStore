//
//  AppsController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsController: BaseListController, UICollectionViewDelegateFlowLayout {

  let cellId = "id"

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .yellow
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
  }

  // MARK: - UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
    return cell
  }

  // MARK: - UICollectionViewFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 250)
  }
}
