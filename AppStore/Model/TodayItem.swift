//
//  TodayItem.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

struct TodayItem {
  let category: String
  let title: String
  let image: UIImage
  let description: String
  let backgroundColor: UIColor
  let cellType: CellType
  var apps: [FeedResult]
  
  enum CellType: String {
    case single
    case multiple
  }
}
