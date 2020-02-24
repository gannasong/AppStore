//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {

  static let reuseId = "ReviewRowCell"

  let reviewsController = ReviewsController()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(reviewsController.view)
    reviewsController.view.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
