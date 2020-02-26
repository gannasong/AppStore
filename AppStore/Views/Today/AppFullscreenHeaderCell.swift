//
//  AppFullscreenHeaderCell.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {

  let todayCell = TodayCell()
  let closebutton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "close_button"), for: .normal)
    return button
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(todayCell)
    addSubview(closebutton)

    todayCell.fillSuperview()
    closebutton.anchor(top: topAnchor,
                       leading: nil,
                       bottom: nil,
                       trailing: trailingAnchor,
                       padding: .init(top: 44, left: 0, bottom: 0, right: 12),
                       size: .init(width: 80, height: 38))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
