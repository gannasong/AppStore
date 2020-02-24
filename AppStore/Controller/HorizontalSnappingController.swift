//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {

  init() {
    let layout = BetterSnappingLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)

    // 使用 .fast 可以讓 targetContentOffset 速度加快
    collectionView.decelerationRate = .fast
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//class SnappingLayout: UICollectionViewFlowLayout {
//  // snap behavior
//  // section 滑動頁面效果
//
//  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//    guard let collectionView = self.collectionView else {
//      return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//    }
//
//    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
//
//    // we're using a magical 48
//    let itemWidth = collectionView.frame.width - 48
//    let itemSpace = itemWidth + minimumInteritemSpacing
//    var pageNumber = round(collectionView.contentOffset.x / itemSpace)
//
//    // Skip to the next cell, if there is residual scrolling velocity left
//    // This helps to prevent glitches
//
//    let vX = velocity.x
//    if vX > 0 {
//      pageNumber += 1
//    } else if vX < 0 {
//      pageNumber -= 1
//    }
//
//    let nearestPageOffset = pageNumber * itemSpace
//    return CGPoint(x: nearestPageOffset, y: parent.y)
//  }
//}
