//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController {

  let cellId = "cellID"
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .blue

    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .red
    return cell
  }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let spacing = (topBottomPadding * 2) + (lineSpacing * 2)
    let height = (view.frame.height - spacing) / 3
    return .init(width: view.frame.width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
  }
}
