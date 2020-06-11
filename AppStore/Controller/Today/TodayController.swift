//
//  TodayController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TodayController: BaseListController, UIGestureRecognizerDelegate {

  static let cellSize: CGFloat = 500

  var startingFrame: CGRect?
  var appFullscreenController: AppFullscreenController!
  var anchoredConstraint: AnchoredConstraints?
  var items = [TodayItem]()
  var appFullscreenBeginOffset: CGFloat = 0

  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .large)
    aiv.color = .darkGray
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()

  let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(blurVisualEffectView)
    blurVisualEffectView.fillSuperview()
    blurVisualEffectView.alpha = 0

    view.addSubview(activityIndicatorView)
    activityIndicatorView.centerInSuperview()

    fetchData()

    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = .systemGray6

    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.superview?.setNeedsLayout()
  }

  // MARK: - UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellId = items[indexPath.item].cellType.rawValue
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
    cell.todayItem = items[indexPath.item]

    (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
    return cell
  }

  @objc private func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
    let collectionView = gesture.view
    var superView = collectionView?.superview

    while superView != nil {
      if let cell = superView as? TodayMultipleAppCell {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        let apps = self.items[indexPath.item].apps
        let fullController = TodayMultipleAppsController(mode: .fullscreen)
        fullController.apps = apps
        let controller = BackEnableNavigationController(rootViewController: fullController)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
      }

      superView = superView?.superview
    }
  }

  fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
    let fullController = TodayMultipleAppsController(mode: .fullscreen)
    fullController.apps = self.items[indexPath.item].apps
    let controller = BackEnableNavigationController(rootViewController: fullController)
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true, completion: nil)
  }

  fileprivate func setupAppFullscreenController(_ indexPath: IndexPath) {
    let appFullscreenController = AppFullscreenController()
    appFullscreenController.todayItem = items[indexPath.item]
    appFullscreenController.dismissHandler = {
      self.handleAppFullscreenDismissal()
    }

    appFullscreenController.view.layer.cornerRadius = 16
    self.appFullscreenController = appFullscreenController
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
    gesture.delegate = self
    appFullscreenController.view.addGestureRecognizer(gesture)
  }

  // MARK: - UIGestureRecognizerDelegate

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }

  @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
    if gesture.state == .began {
      appFullscreenBeginOffset = appFullscreenController.tableView.contentOffset.y
    }

    let translationY = gesture.translation(in: appFullscreenController.view).y

    if appFullscreenController.tableView.contentOffset.y > 0 {
      return
    }

    if gesture.state == .changed {
      if translationY > 0 {
        let trueOffset = translationY - appFullscreenBeginOffset
        var scale = 1 - translationY / 1000
        print(trueOffset, scale)
        scale = min(1, scale) // 控制縮小範圍
        scale = max(0.5, scale)

        let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
        self.appFullscreenController.view.transform = transform
      }

    } else if gesture.state == .ended {
      if translationY > 0 {
        handleAppFullscreenDismissal()
      }
    }
  }

  fileprivate func setupAppFullscreenStartingPosition(indexPath: IndexPath) {
    let fullscreenView = appFullscreenController.view!
    view.addSubview(fullscreenView)
    addChild(appFullscreenController)

    self.collectionView.isUserInteractionEnabled = false

    setupStartingCellFrame(indexPath)

    guard let startingFrame = self.startingFrame else { return }

    self.anchoredConstraint = fullscreenView.anchor(top: view.topAnchor,
                                                    leading: view.leadingAnchor,
                                                    bottom: nil,
                                                    trailing: nil,
                                                    padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0),
                                                    size: .init(width: startingFrame.width, height: startingFrame.height))


    self.view.layoutIfNeeded() // 這邊跟下面都要加才有動畫效果
  }

  fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return } // 拿到 cell

    // absolute coordindates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame
  }

  fileprivate func beginAnimatioAppFullscreen() {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.blurVisualEffectView.alpha = 1
                    self.anchoredConstraint?.top?.constant = 0
                    self.anchoredConstraint?.leading?.constant = 0
                    self.anchoredConstraint?.width?.constant = self.view.frame.width
                    self.anchoredConstraint?.height?.constant = self.view.frame.height
                    self.view.layoutIfNeeded() // starts animation 這邊跟上面都要加才有動畫效果

                    self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height

                    guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
                    cell.todayCell.topConstraint.constant = 48
                    cell.layoutIfNeeded()
    }, completion: nil)
  }

  fileprivate func showSingleAppFullscreen(indexPath: IndexPath) {
    // 1
    setupAppFullscreenController(indexPath)

    // 2 setup fullscreen in its sttarting position
    setupAppFullscreenStartingPosition(indexPath: indexPath)

    // 3 begin the fullscreen animation
    beginAnimatioAppFullscreen()
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch items[indexPath.item].cellType {
      case .multiple:
        showDailyListFullScreen(indexPath)
      case .single:
        showSingleAppFullscreen(indexPath: indexPath)
    }
  }

  @objc private func handleAppFullscreenDismissal() {
    // access startingFrame
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.blurVisualEffectView.alpha = 0
                    self.appFullscreenController.view.transform = .identity

                    self.appFullscreenController.tableView.contentOffset = .zero

                    guard let staringFrame = self.startingFrame else { return }
                    self.anchoredConstraint?.top?.constant = staringFrame.origin.y
                    self.anchoredConstraint?.leading?.constant = staringFrame.origin.x
                    self.anchoredConstraint?.width?.constant = staringFrame.width
                    self.anchoredConstraint?.height?.constant = staringFrame.height
                    self.view.layoutIfNeeded()

                    if let tabBarFrame = self.tabBarController?.tabBar.frame {
                      self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
                    }

                    guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
                    self.appFullscreenController.closebutton.alpha = 0
                    cell.todayCell.topConstraint.constant = 24
                    cell.layoutIfNeeded()
    }, completion: { _ in
      self.appFullscreenController.view.removeFromSuperview()
      self.appFullscreenController.removeFromParent()
      self.collectionView.isUserInteractionEnabled = true
    })
  }

  private func fetchData() {
    let dispatchGroup = DispatchGroup()
    var topGrossingGroup: AppGroup?
    var gameGroup: AppGroup?

    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, error) in
      topGrossingGroup = appGroup
      dispatchGroup.leave()
    }

    dispatchGroup.enter()
    Service.shared.fetchGames { (appGroup, error) in
      gameGroup = appGroup
      dispatchGroup.leave()
    }

    // completion block
    dispatchGroup.notify(queue: .main) {
      print("Finished fetching")
      self.activityIndicatorView.stopAnimating()
      
      self.items = [
        TodayItem.init(category: "LIFE HACK",
                       title: "Utilizing your Time",
                       image: UIImage(named: "garden")!,
                       description: "All the tools and apps you need to intelligently organize your life the right way.",
                       backgroundColor: .white,
                       cellType: .single, apps: []),
        TodayItem.init(category: "HOLIDAYS",
                       title: "Travel on a Budget",
                       image: UIImage(named: "holiday")!,
                       description: "Find out all you need to know on how to travel without packing everything!",
                       backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1),
                       cellType: .single, apps: []),
        TodayItem.init(category: "Daily List",
                       title: topGrossingGroup?.feed.title ?? "",
                       image: UIImage(named: "garden")!,
                       description: "",
                       backgroundColor: .white,
                       cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
        TodayItem.init(category: "Daily List",
                       title: gameGroup?.feed.title ?? "",
                       image: UIImage(named: "garden")!,
                       description: "",
                       backgroundColor: .white,
                       cellType: .multiple, apps: gameGroup?.feed.results ?? []),
      ]

      self.collectionView.reloadData()
    }
  }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 64, height: TodayController.cellSize)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 32
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 32, left: 0, bottom: 32, right: 0)
  }
}
