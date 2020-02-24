//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {

  let cellId = "cellID"
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10
  var appGroup: AppGroup?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white

    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
    let app = appGroup?.feed.results[indexPath.item]
    cell.nameLabel.text = app?.name
    cell.companyLabel.text = app?.artistName
    cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
    return cell
  }
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let spacing = (topBottomPadding * 2) + (lineSpacing * 2)
    let height = (view.frame.height - spacing) / 3
    return .init(width: view.frame.width - 48, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
  }
}
