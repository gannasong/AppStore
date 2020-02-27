//
//  AppFullscreenController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppFullscreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var dismissHandler: (() -> Void)?
  var todayItem: TodayItem?
  let tableView = UITableView(frame: .zero, style: .plain)
  let floatingcontainerView = UIView()

  let closebutton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "close_button"), for: .normal)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.clipsToBounds = true

    view.addSubview(tableView)
    tableView.fillSuperview()
    tableView.dataSource = self
    tableView.delegate = self

    setupCloseButton()

    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
    tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)

    setupFloatingControls()
  }

  @objc fileprivate func handleTap() {
    UIView.animate(withDuration: 0.7,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.floatingcontainerView.transform = .init(scaleX: 0, y: -90)
    }, completion: nil)
  }

  fileprivate func setupFloatingControls() {
    floatingcontainerView.layer.cornerRadius = 16
    floatingcontainerView.clipsToBounds = true
    view.addSubview(floatingcontainerView)
//    let bottomPadding = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44

    floatingcontainerView.anchor(top: nil,
                                 leading: view.leadingAnchor,
                                 bottom: view.bottomAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .init(top: 0, left: 16, bottom: -90, right: 16),
                                 size: .init(width: 0, height: 90))

    let blurVisualEffactView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    floatingcontainerView.addSubview(blurVisualEffactView)
    blurVisualEffactView.fillSuperview()

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

    let getButton = UIButton(title: "GET")
    getButton.setTitleColor(.white, for: .normal)
    getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    getButton.backgroundColor = .darkGray
    getButton.layer.cornerRadius = 16
    getButton.constrainWidth(constant: 80)
    getButton.constrainHeight(constant: 32)

    // add our subviews
    let imageView = UIImageView(cornerRadius: 16)
    imageView.image = todayItem?.image
    imageView.constrainHeight(constant: 68)
    imageView.constrainWidth(constant: 68)

    let stackView = UIStackView(arrangedSubviews: [
      imageView,
      VerticalStackView(arrangedSubviews: [
        UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
        UILabel(text: "Utilizing your time", font: .systemFont(ofSize: 16)),
      ], spacing: 4),
      getButton
    ], customSpacing: 16)

    floatingcontainerView.addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    stackView.alignment = .center
  }

  fileprivate func setupCloseButton() {
    view.addSubview(closebutton)
    closebutton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       leading: nil,
                       bottom: nil,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 12, left: 0, bottom: 0, right: 0),
                       size: .init(width: 80, height: 40))
    closebutton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let headerCell = AppFullscreenHeaderCell()
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      headerCell.clipsToBounds = true
      headerCell.todayCell.backgroundView = nil
      return headerCell
    }

    let cell = AppFullscreenDescriptionCell()
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.item == 0 {
      return TodayController.cellSize
    }
    return UITableView.automaticDimension
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      scrollView.isScrollEnabled = true
    }

    let translationY: CGFloat = -90 - 44
    let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity

    UIView.animate(withDuration: 0.8,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.7,
                   options: .curveEaseOut, animations: {
                    self.floatingcontainerView.transform = transform
    })

//    if scrollView.contentOffset.y > 100 {
//      if floatingcontainerView.transform == .identity {
//        UIView.animate(withDuration: 0.7,
//                       delay: 0,
//                       usingSpringWithDamping: 0.7,
//                       initialSpringVelocity: 0.7,
//                       options: .curveEaseOut,
//                       animations: {
//                        let translationY: CGFloat = -90 - 44
//                        self.floatingcontainerView.transform = .init(scaleX: 0, y: translationY)
//        })
//      }
//    } else {
//      UIView.animate(withDuration: 0.7,
//                     delay: 0,
//                     usingSpringWithDamping: 0.7,
//                     initialSpringVelocity: 0.7,
//                     options: .curveEaseOut,
//                     animations: {
//                      self.floatingcontainerView.transform = .identity
//      })
//    }
  }

  // MARK: - Private Methods

  @objc private func handleDismiss(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
}
