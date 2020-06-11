//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

  let cellId = "cellId"
  var socialApps = [SocialApp]()

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  // header of item size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return socialApps.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
    let app = self.socialApps[indexPath.item]
    cell.companyLabel.text = app.name
    cell.titleLabel.text = app.tagline
    cell.imageView.sd_setImage(with: URL(string: app.imageUrl), completed: nil)
    return cell
  }
}
