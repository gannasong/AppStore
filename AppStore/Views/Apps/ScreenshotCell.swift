//
//  ScreenshotCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {

  static let reuseId = "ScreenshotCell"

  let imageView = UIImageView(cornerRadius: 12)

  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
    imageView.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
