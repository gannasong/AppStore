//
//  AppCompositionalView.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/27.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import SwiftUI

class CompositionalController: UICollectionViewController {

  var socialApps = [SocialApp]()
  var games: AppGroup?

  // MARK: - Initialization

  init() {
    let layout = UICollectionViewCompositionalLayout.init { (sectionNumber, _) -> NSCollectionLayoutSection? in
      if sectionNumber == 0 {
        return CompositionalController.topSection()
      } else {
        // section section

        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1/3)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                                                                       heightDimension: .absolute(300)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16

        let kind = UICollectionView.elementKindSectionHeader
        section.boundarySupplementaryItems = [
          .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .absolute(50)),
                elementKind: kind,
                alignment: .topLeading)
        ]


        return section
      }
    }
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UIViewControlelr

  override func viewDidLoad() {
    super.viewDidLoad()
    // Header
    collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CompositionalHeader.reuseId)

    // Cell
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: AppsHeaderCell.reuseId)
    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.reuseId)

    collectionView.backgroundColor = .systemBackground
    navigationItem.title = "Apps"
    navigationController?.navigationBar.prefersLargeTitles = true

    fetchApps()
  }

  // MARK: - UICollectionViewDelegate

  private func fetchApps() {
    Service.shared.fetchSocialApps { (apps, error) in
      self.socialApps = apps ?? []
      Service.shared.fetchGames { (appGroup, error) in
        self.games = appGroup
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return socialApps.count
    } else {
      return games?.feed.results.count ?? 0
    }
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
      case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCell.reuseId, for: indexPath) as! AppsHeaderCell
        let socialApp = self.socialApps[indexPath.item]
        cell.titleLabel.text = socialApp.tagline
        cell.companyLabel.text = socialApp.name
        cell.imageView.sd_setImage(with: URL(string: socialApp.imageUrl))
        return cell
      case 1:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.reuseId, for: indexPath) as! AppRowCell
        let app = self.games?.feed.results[indexPath.item]
        cell.nameLabel.text = app?.name
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        cell.companyLabel.text = app?.artistName
        return cell
      default: return UICollectionViewCell()
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var apdId = ""

    if indexPath.section == 0 {
      apdId = socialApps[indexPath.item].id
    } else {
      apdId = games?.feed.results[indexPath.item].id ?? ""
    }
    let appDetailController = AppDetailController(appId: apdId)
    navigationController?.pushViewController(appDetailController, animated: true)
  }

  // MARK: - Header Cell

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CompositionalHeader.reuseId, for: indexPath)
    return header
  }

  // MARK: - Static Methods

  static func topSection() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(1)))
    item.contentInsets.bottom = 16
    item.contentInsets.trailing = 16

    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                                                                     heightDimension: .absolute(300)),
                                                   subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets.leading = 16
    return section
  }
}


class CompositionalHeader: UICollectionReusableView {

  static let reuseId = "CompositionalHeader"

  let label = UILabel(text: "Editor's Choise Games",
                      font: .boldSystemFont(ofSize: 32))

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    label.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }
}


// 使用 SwiftUI Preview，快速可以看到更動的效果
struct AppsView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<AppsView>) -> UIViewController {
    let controller = CompositionalController()
    return UINavigationController(rootViewController: controller)
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AppsView>) {
  }

  typealias UIViewControllerType = UIViewController
}

struct AppsCompositionalView_Previews: PreviewProvider {
  static var previews: some View {
    AppsView()
      .edgesIgnoringSafeArea(.all)
  }
}
