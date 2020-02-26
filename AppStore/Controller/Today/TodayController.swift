//
//  TodayController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TodayController: BaseListController {

  static let cellSize: CGFloat = 500

  var startingFrame: CGRect?
  var appFullscreenController: AppFullscreenController!
  var topConstraint: NSLayoutConstraint?
  var leadingConstraint: NSLayoutConstraint?
  var widthConstraint: NSLayoutConstraint?
  var heightConstraint: NSLayoutConstraint?
  var items = [TodayItem]()

  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .large)
    aiv.color = .darkGray
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(activityIndicatorView)
    activityIndicatorView.centerInSuperview()

    fetchData()

    navigationController?.isNavigationBarHidden = true
    collectionView.backgroundColor = .systemGray6

    collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
    collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
  }

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
        fullController.modalPresentationStyle = .fullScreen
        present(fullController, animated: true)
      }

      superView = superView?.superview
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if items[indexPath.item].cellType == .multiple {
      let fullController = TodayMultipleAppsController(mode: .fullscreen)
      fullController.apps = self.items[indexPath.item].apps
      let controller = BackEnableNavigationController(rootViewController: fullController)
      controller.modalPresentationStyle = .fullScreen
      present(controller, animated: true, completion: nil)
      return
    }

    let appFullscreenController = AppFullscreenController()
    appFullscreenController.todayItem = items[indexPath.item]
    appFullscreenController.dismissHandler = {
      self.handleRemoveRedView()
    }

    let fullscreenView = appFullscreenController.view!
    view.addSubview(fullscreenView)
    addChild(appFullscreenController)
    self.appFullscreenController = appFullscreenController
    self.collectionView.isUserInteractionEnabled = false

    guard let cell = collectionView.cellForItem(at: indexPath) else { return } // 拿到 cell

    // absolute coordindates of cell
    guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
    self.startingFrame = startingFrame

    fullscreenView.translatesAutoresizingMaskIntoConstraints = false
    topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
    leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
    widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
    heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
    [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach { $0?.isActive = true }

    self.view.layoutIfNeeded() // 這邊跟下面都要加才有動畫效果

    fullscreenView.layer.cornerRadius = 16

    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.topConstraint?.constant = 0
                    self.leadingConstraint?.constant = 0
                    self.widthConstraint?.constant = self.view.frame.width
                    self.heightConstraint?.constant = self.view.frame.height
                    self.view.layoutIfNeeded() // starts animation 這邊跟上面都要加才有動畫效果

                    self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height

                    guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
                    cell.todayCell.topConstraint.constant = 48
                    cell.layoutIfNeeded()
    }, completion: nil)
  }

  @objc private func handleRemoveRedView() {
    // access startingFrame
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.appFullscreenController.tableView.contentOffset = .zero

                    guard let staringFrame = self.startingFrame else { return }
                    self.topConstraint?.constant = staringFrame.origin.y
                    self.leadingConstraint?.constant = staringFrame.origin.x
                    self.widthConstraint?.constant = staringFrame.width
                    self.heightConstraint?.constant = staringFrame.height
                    self.view.layoutIfNeeded()

                    if let tabBarFrame = self.tabBarController?.tabBar.frame {
                      self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
                    }

                    guard let cell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
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
                       cellType: .single, apps: [])
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
