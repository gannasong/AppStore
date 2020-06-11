//
//  TodayMultipleAppCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {

  static let reuseId = "TodayMultipleAppCell"
  
  override var todayItem : TodayItem! {
    didSet {
      categoryLabel.text = todayItem.category
      titleLabel.text = todayItem.title
      multipleAppsController.apps = todayItem.apps
      multipleAppsController.collectionView.reloadData()
    }
  }

  let categoryLabel = UILabel(text: "LIFE Hack",
                              font: .boldSystemFont(ofSize: 20))

  let titleLabel = UILabel(text: "Utilizing your time",
                           font: .boldSystemFont(ofSize: 32),
                           numberOfLines: 2)

  let multipleAppsController = TodayMultipleAppsController(mode: .small)

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 16

    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLabel,
      titleLabel,
      multipleAppsController.view
    ], spacing: 12)

    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
