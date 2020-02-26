//
//  AppFullscreenController.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/25.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class AppFullscreenController: UITableViewController {

  var dismissHandler: (() -> Void)?
  var todayItem: TodayItem?

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
    tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.item == 0 {
      let headerCell = AppFullscreenHeaderCell()
      headerCell.closebutton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      return headerCell
    }

    let cell = AppFullscreenDescriptionCell()
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.item == 0 {
      return TodayController.cellSize
    }
    return super.tableView(tableView, heightForRowAt: indexPath)
  }

  // MARK: - Private Methods

  @objc private func handleDismiss(button: UIButton) {
    button.isHidden = true
    dismissHandler?()
  }
}
