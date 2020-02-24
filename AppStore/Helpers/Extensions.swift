//
//  Extensions.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

extension UILabel {
  convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
    self.init(frame: .zero)
    self.text = text
    self.font = font
    self.numberOfLines = numberOfLines
  }
}

extension UIImageView {
  convenience init(cornerRadius: CGFloat) {
    self.init(image: nil)
    self.layer.cornerRadius = cornerRadius
    self.clipsToBounds = true
    self.contentMode = .scaleAspectFill
  }
}

extension UIButton {
  convenience init(title: String) {
    self.init(type: .system)
    self.setTitle(title, for: .normal)
  }
}
