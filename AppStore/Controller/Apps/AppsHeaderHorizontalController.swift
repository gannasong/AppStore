//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/19.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: BaseListController, UICollectionViewDelegateFlowLayout {

  let cellId = "cellId"

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)

    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
    }

    fetchData()
  }

  // header 內 item 大笑
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }

  // item 的邊界
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 16, bottom: 0, right: 0)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
    return cell
  }

  fileprivate func fetchData() {
    Service.shared.fetchGames { (appGroup, error) in
      if let error = error {
        print("Failed to fetch games:", error)
        return
      }
      print("-----> ")
      print(appGroup?.feed.results)
    }
  }
}
