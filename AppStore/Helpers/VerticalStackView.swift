//
//  VerticalStackView.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/14.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {

  // MARK: - Initialization

  init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
    super.init(frame: .zero)
    self.spacing = spacing
    self.axis = .vertical
    arrangedSubviews.forEach { addArrangedSubview($0) }
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
