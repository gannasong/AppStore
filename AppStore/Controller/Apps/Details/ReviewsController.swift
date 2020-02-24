//
//  ReviewsController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController {

  var revies: Reviews? {
    didSet {
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reuseId)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return revies?.feed.entry.count ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reuseId, for: indexPath) as! ReviewCell
    let entry = self.revies?.feed.entry[indexPath.item]
    cell.titleLabel.text = entry?.title.label
    cell.authorLabel.text = entry?.author.name.label
    cell.bodyLabel.text = entry?.content.label

    for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
      if let ratingInt = Int(entry!.rating.label) {
        view.alpha = index >= ratingInt ? 0 : 1
      }
    }
    return cell
  }
}

extension ReviewsController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
