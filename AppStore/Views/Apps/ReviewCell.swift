//
//  ReviewCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {

  static let reuseId = "ReviewCell"

  let titleLabel = UILabel(text: "Review Title",
                           font: .boldSystemFont(ofSize: 18))

  let authorLabel = UILabel(text: "Author",
                            font: .systemFont(ofSize: 16))

  let starsLabel = UILabel(text: "Stars",
                          font: .systemFont(ofSize: 14))

  let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n",
                          font: .systemFont(ofSize: 18), numberOfLines: 5)

  let starsStackView: UIStackView = {
    var arrangedSubviews = [UIView]()
    (0..<5).forEach { _ in
      let imageView = UIImageView(image: UIImage(named: "star"))
      imageView.constrainWidth(constant: 24)
      imageView.constrainHeight(constant: 24)
      arrangedSubviews.append(imageView)
    }

    arrangedSubviews.append(UIView()) // white space
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray6
    layer.cornerRadius = 16
    clipsToBounds = true


    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        titleLabel,
        authorLabel
      ], customSpacing: 8),
      starsStackView,
      bodyLabel
    ], spacing: 12)

    titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    authorLabel.textAlignment = .right

    addSubview(stackView)

    // 修正 review cell 間距
    stackView.anchor(top: topAnchor,
                     leading: leadingAnchor,
                     bottom: nil,
                     trailing: trailingAnchor,
                     padding: .init(top: 20, left: 20, bottom: 0, right: 20))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
