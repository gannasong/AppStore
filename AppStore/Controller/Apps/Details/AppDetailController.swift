//
//  AppDetailController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/24.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {

  var app: Result?
  var reviews: Reviews?
  let appId: String

  // MARK: - Initialization

  // dependency injection constructor
  init(appId: String) {
    self.appId = appId
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white

    collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.reuseId)
    collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.reuseId)
    collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: ReviewRowCell.reuseId)
    navigationItem.largeTitleDisplayMode = .never

    fetchData()
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.reuseId, for: indexPath) as! AppDetailCell
      cell.app = app
      return cell
    } else if indexPath.item == 1 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.reuseId, for: indexPath) as! PreviewCell
      cell.horizontalController.app = self.app
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewRowCell.reuseId, for: indexPath) as! ReviewRowCell
      cell.reviewsController.revies = self.reviews
      return cell
    }
  }

  // MARK: - Private Methods

  private func fetchData() {
    let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
    Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
      let app = result?.results.first
      self.app = app
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }

    let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
    Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
      if let error = error {
        print("Failed to decode reviews", error)
        return
      }

      self.reviews = reviews
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    var height: CGFloat = 280

    if indexPath.item == 0 {
      // calculate the necessary size for our cell showhow
      let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
      dummyCell.app = app
      dummyCell.layoutIfNeeded() // 重新 layout

      let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
      height = estimatedSize.height
    } else if indexPath.item == 1 {
      height = 500
    } else {
      height = 280
    }

    return .init(width: view.frame.width, height: height)
  }

  // add review cell space
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 16, right: 0)
  }
}
