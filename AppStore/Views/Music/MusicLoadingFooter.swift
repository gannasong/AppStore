//
//  MusicLoadingFooter.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/27.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {

  static let reuseId = "MusicLoadingFooter"

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    let aiv = UIActivityIndicatorView(style: .large)
    aiv.color = .darkGray
    aiv.startAnimating()

    let label = UILabel(text: "Loading more...",
                        font: .systemFont(ofSize: 16))
    label.textAlignment = .center
    let stackView = VerticalStackView(arrangedSubviews: [
      aiv,
      label
    ], spacing: 8)
    addSubview(stackView)
    stackView.centerInSuperview(size: .init(width: 200, height: 0))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
