//
//  PreviewScreenshotsController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController {

  var app: Result? {
    didSet {
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return app?.screenshotUrls.count ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseId, for: indexPath) as! ScreenshotCell
    let screenshotUrl = self.app?.screenshotUrls[indexPath.item]
    cell.imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
    return cell
  }
}

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: 250, height: view.frame.height)
  }
}
