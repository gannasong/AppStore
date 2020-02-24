//
//  AppSearchController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/12.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit
import SDWebImage

class AppSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

  fileprivate let cellId = "cell"
  fileprivate var appResults: [Result] = []
  fileprivate let searchController = UISearchController(searchResultsController: nil)

  fileprivate let enterSearchTermLabel: UILabel = {
    let enterSearchTermLabel = UILabel()
    enterSearchTermLabel.text = "Please enter search term above..."
    enterSearchTermLabel.textAlignment = .center
    enterSearchTermLabel.font = UIFont.boldSystemFont(ofSize: 20)
    return enterSearchTermLabel
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)

    collectionView.addSubview(enterSearchTermLabel)
    enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))

    setupSearchBar()
//    fetchITunesApps()
  }

  // MARK: - UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
    cell.appResult = appResults[indexPath.item]
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    enterSearchTermLabel.isHidden = appResults.count != 0
    return appResults.count
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = String(appResults[indexPath.item].trackId)
    let appDetailController = AppDetailController(appId: appId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }

  // MARK: - UISearchBarDelegate

  var timer: Timer?

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
      Service.shared.fetchApps(searchTerm: searchText) { (res, error) in
        if let error = error {
          print("Failed to fetch apps:", error)
          return
        }

        self.appResults = res?.results ?? []
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
  }

  // MARK: - Private Methods

  fileprivate func setupSearchBar() {
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
  }

  fileprivate func fetchITunesApps() {
    Service.shared.fetchApps(searchTerm: "Twitter") { (res, err) in

      if let err = err {
        print("Failed to fetch apps:", err)
        return
      }
      
      self.appResults = res?.results ?? []
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
}
