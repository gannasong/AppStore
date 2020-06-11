//
//  TodayMultipleAppsController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/26.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

enum Mode {
  case small
  case fullscreen
}

class TodayMultipleAppsController: BaseListController {

  var apps = [FeedResult]()
  fileprivate var spacing: CGFloat = 16
  fileprivate let mode: Mode
  override var prefersStatusBarHidden: Bool { return true }

  let closebutton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "close_button"), for: .normal)
    button.tintColor = .darkGray
    button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return button
  }()

  // MARK: - Initialization

  init(mode: Mode) {
    self.mode = mode
    super.init()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if mode == .fullscreen {
      setupCloseButton()
      navigationController?.isNavigationBarHidden = true
    } else {
      collectionView.isScrollEnabled = false // Avoid scroll in cell
    }

    collectionView.backgroundColor = .white
    collectionView.register(MutipleAppCell.self, forCellWithReuseIdentifier: MutipleAppCell.reuseId)
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if mode == .fullscreen {
      return apps.count
    }
    return min(4, apps.count)
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MutipleAppCell.reuseId, for: indexPath) as! MutipleAppCell
    cell.app = apps[indexPath.item]
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = self.apps[indexPath.item].id
    let appDetailController = AppDetailController(appId: appId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }

  // MARK: - Private Methods

  private func setupCloseButton() {
    view.addSubview(closebutton)
    closebutton.anchor(top: view.topAnchor,
                       leading: nil,
                       bottom: nil,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 20, left: 0, bottom: 0, right: 16),
                       size: .init(width: 44, height: 44))
  }

  @objc private func handleDismiss() {
    dismiss(animated: true, completion: nil)
  }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height: CGFloat = 68
    if mode == .fullscreen {
      return .init(width: view.frame.width - 48, height: height)
    }

    return .init(width: view.frame.width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullscreen {
      return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    return .zero
  }
}
