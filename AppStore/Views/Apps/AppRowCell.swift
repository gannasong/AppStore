//
//  AppRowCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {

  static let reuseId = "AppRowCell"

  var app: FeedResult! {
    didSet {
      nameLabel.text = app.name
      companyLabel.text = app.artistName
      imageView.sd_setImage(with: URL(string: app.artworkUrl100))
    }
  }

  let imageView = UIImageView(cornerRadius: 8)

  let nameLabel = UILabel(text: "App Name",
                          font: .systemFont(ofSize: 20))
  let companyLabel = UILabel(text: "Company Name",
                             font: .systemFont(ofSize: 13))

  let getButton = UIButton(title: "GET")

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView.backgroundColor = .purple
    imageView.constrainHeight(constant: 64)
    imageView.constrainWidth(constant: 64)

    getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)
    getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    getButton.layer.cornerRadius = 32 / 2

    let stackView = UIStackView(arrangedSubviews: [
      imageView,
      VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
      getButton
    ])
    stackView.spacing = 16

    stackView.alignment = .center // 置中

    addSubview(stackView)
    stackView.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
