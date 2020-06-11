//
//  MusicController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/27.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class MusicController: BaseListController {

  var results = [Result]()
  var isPaginating = false
  var isDonePaginating = false

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(TrackCell.self, forCellWithReuseIdentifier: TrackCell.reuseId)
    collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MusicLoadingFooter.reuseId)

    fetchData()
  }

  fileprivate let searchTerm = "taylor"

  fileprivate func fetchData() {
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
    Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
      if let error = error {
        print("Failed to panginate data:", error)
      }

      if searchResult?.results.count == 0 {
        self.isDonePaginating = true
      }

      self.results = searchResult?.results ?? []
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
    let track = results[indexPath.item]
    cell.nameLabel.text = track.trackName
    cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
    cell.subtitleLabel.text = "\(track.artistName ?? "") - \(track.collectionName ?? "")"

    // initiate pagination
    if indexPath.item == results.count - 1 && !isPaginating {
      print("fetch more data")
      isPaginating = true

      let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
      Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
        if let error = error {
          print("Failed to panginate data:", error)
        }

        sleep(2)
        self.results += searchResult?.results ?? []
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
        self.isPaginating = false
      }
    }

    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicLoadingFooter.reuseId, for: indexPath) as! MusicLoadingFooter
    return footer
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let height: CGFloat = isDonePaginating ? 0 : 100
    return .init(width: view.frame.width, height: height)
  }
}

extension MusicController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 100)
  }
}
