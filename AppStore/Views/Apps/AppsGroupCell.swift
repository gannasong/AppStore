//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {

  let titleLabel = UILabel(text: "App Section",
                           font: .boldSystemFont(ofSize: 30))

  let horizontalController = AppsHorizontalController()

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = . lightGray

    addSubview(titleLabel)
    titleLabel.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: nil,
                      trailing: trailingAnchor)

    addSubview(horizontalController.view)
    horizontalController.view.backgroundColor = .blue
    horizontalController.view.anchor(top: titleLabel.bottomAnchor,
                                     leading: leadingAnchor,
                                     bottom: bottomAnchor,
                                     trailing: trailingAnchor)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension UILabel {
  convenience init(text: String, font: UIFont) {
    self.init(frame: .zero)
    self.text = text
    self.font = font
  }
}
