//
//  TrackCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/27.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {

  static let reuseId = "TrackCell"

  let imageView = UIImageView(cornerRadius: 16)
  let nameLabel = UILabel(text: "Track Name",
                          font: .boldSystemFont(ofSize: 18))
  let subtitleLabel = UILabel(text: "Subtitle label",
                              font: .systemFont(ofSize: 16),
                              numberOfLines: 2)

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView.image = UIImage(named: "garden")
    imageView.constrainWidth(constant: 80)

    // Horizonal
    let stackView = UIStackView(arrangedSubviews: [
      imageView,
      VerticalStackView(arrangedSubviews: [ // Vertical
        nameLabel,
        subtitleLabel
      ], spacing: 16),
    ], customSpacing: 16)

    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    stackView.alignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
