//
//  TodayCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {

  static let reuseId = "TodayCell"
  var topConstraint: NSLayoutConstraint!

  override var todayItem: TodayItem! {
    didSet {
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      imageView.image = todayItem.image
      descriptionLabel.text = todayItem.description
      backgroundColor = todayItem.backgroundColor
    }
  }

  let imageView = UIImageView(image: UIImage(named: "garden"))
  let categoryLabel = UILabel(text: "LIFE Hack",
                              font: .boldSystemFont(ofSize: 20))

  let titleLabel = UILabel(text: "Utilizing your time",
                           font: .boldSystemFont(ofSize: 28))

  let descriptionLabel = UILabel(text: "FDFD FDF DFDFDSFSD FDS FDSGREGREGDF FDSFDSF FDSFSDFEFSDFDSF Fds FDS Fds FSD FDS Fsd",
                                 font: .systemFont(ofSize: 16),
                                 numberOfLines: 3)

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 16
    clipsToBounds = true
    
    imageView.contentMode = .scaleAspectFill

    let imageContainerView = UIView()
    imageContainerView.addSubview(imageView)
    imageView.centerInSuperview(size: .init(width: 240, height: 240))

    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      imageContainerView,
      descriptionLabel
    ], spacing: 8)

    addSubview(stackView)
    stackView.anchor(top: nil,
                     leading: leadingAnchor,
                     bottom: bottomAnchor,
                     trailing: trailingAnchor,
                     padding: .init(top: 24, left: 24, bottom: 24, right: 24))

    self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
    self.topConstraint.isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
