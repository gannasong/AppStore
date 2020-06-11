//
//  AppsPageController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/18.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {

  let cellId = "id"
  let headerId = "headerId"

  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .large)
    aiv.color = .black
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(AppPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)

    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()

    fetchData()
  }

  var socialApps = [SocialApp]()
  var groups = [AppGroup]()

  fileprivate func fetchData() {
    var group1: AppGroup?
    var group2: AppGroup?
    var group3: AppGroup?

    // help you sync your data fetches together
    let dispatchGroup = DispatchGroup()

    // 呼叫 enter 就必須要呼叫 leave，不然不會呼叫 notify
    //    dispatchGroup.enter()
    //    dispatchGroup.leave()

    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      print("Done with games")
      dispatchGroup.leave()
      group1 = appGroup
    }

    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, error) in
      print("Done with topGrossing")
      dispatchGroup.leave()
      group2 = appGroup
    }

    dispatchGroup.enter()
    Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") { (appGroup, error) in
      print("Done with free game")
      dispatchGroup.leave()
      group3 = appGroup
    }

    dispatchGroup.enter()
    Service.shared.fetchSocialApps { (apps, error) in
      // you should check the err
      dispatchGroup.leave()
      self.socialApps = apps ?? []
    }

    // completion
    dispatchGroup.notify(queue: .main) {
      print("completed your dispatch group tasks...")

      self.activityIndicatorView.stopAnimating()

      if let group = group1 {
        self.groups.append(group)
      }
      if let group = group2 {
        self.groups.append(group)
      }
      if let group = group3 {
        self.groups.append(group)
      }
      self.collectionView.reloadData()
    }
  }

  // MARK: - Header

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppPageHeader
    header.appHeaderHorizontalController.socialApps = self.socialApps
    header.appHeaderHorizontalController.collectionView.reloadData()
    return header
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }

  // MARK: - UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell

    let appGroups = groups[indexPath.item]

    cell.titleLabel.text = appGroups.feed.title
    cell.horizontalController.appGroup = appGroups
    cell.horizontalController.collectionView.reloadData()
    cell.horizontalController.didSelectHandler = { [weak self] feedResult in
      let controller = AppDetailController(appId: feedResult.id)
      controller.navigationItem.title = feedResult.name
      self?.navigationController?.pushViewController(controller, animated: true)
    }
    return cell
  }

  // MARK: - UICollectionViewFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
}
