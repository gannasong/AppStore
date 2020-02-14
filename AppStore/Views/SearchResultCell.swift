//
//  SearchResultCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/13.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {

  lazy var appIconImageView: UIImageView = {
    let appIconImageView = UIImageView()
    appIconImageView.backgroundColor = .red
    appIconImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    appIconImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    appIconImageView.layer.cornerRadius = 12
    return appIconImageView
  }()

  lazy var nameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.text = "APP NAME"
    return nameLabel
  }()

  lazy var categoryLabel: UILabel = {
    let categoryLabel = UILabel()
    categoryLabel.text = "Photos & Video"
    return categoryLabel
  }()

  lazy var ratingsLabel: UILabel = {
    let ratingsLabel = UILabel()
    ratingsLabel.text = "9.26M"
    return ratingsLabel
  }()

  lazy var getButton: UIButton = {
    let getButton = UIButton(type: .system)
    getButton.setTitle("GET", for: .normal)
    getButton.setTitleColor(.blue, for: .normal)
    getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
    getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    getButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    getButton.layer.cornerRadius = 16
    return getButton
  }()

  lazy var screenshot1ImageView = self.createScreenshotImageView()
  lazy var screenshot2ImageView = self.createScreenshotImageView()
  lazy var screenshot3ImageView = self.createScreenshotImageView()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)

    let infoTopStackView = UIStackView(arrangedSubviews: [
      appIconImageView,
      VerticalStackView(arrangedSubviews: [
        nameLabel, categoryLabel, ratingsLabel
      ]),
      getButton
    ])

    infoTopStackView.spacing = 12
    infoTopStackView.alignment = .center

    let screenshotStackView = UIStackView(arrangedSubviews: [
      screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
    ])
    screenshotStackView.spacing = 12
    screenshotStackView.distribution = .fillEqually

    let overallStackView = VerticalStackView(arrangedSubviews: [
      infoTopStackView, screenshotStackView
    ], spacing: 16)

    addSubview(overallStackView)
    overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Methods

  private func createScreenshotImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.backgroundColor = .blue
    return imageView
  }
}
