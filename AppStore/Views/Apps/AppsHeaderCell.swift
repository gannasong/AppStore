//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {

  static let reuseId = "AppsHeaderCell"

  var app: SocialApp! {
    didSet {
      companyLabel.text = app.name
      titleLabel.text = app.tagline
      imageView.sd_setImage(with: URL(string: app.imageUrl))
    }
  }

  let companyLabel = UILabel(text: "Facebook",
                        font: .boldSystemFont(ofSize: 12))

  let titleLabel = UILabel(text: "Keeping up with friends is faster than ever",
                           font: .systemFont(ofSize: 24))

  let imageView = UIImageView(cornerRadius: 8)

  override init(frame: CGRect) {
    super.init(frame: frame)

    companyLabel.textColor = .blue
    titleLabel.numberOfLines = 2
    imageView.image = UIImage(named: "holiday")

    let stackView = VerticalStackView(arrangedSubviews: [
      companyLabel,
      titleLabel,
      imageView
    ], spacing: 12)

    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
