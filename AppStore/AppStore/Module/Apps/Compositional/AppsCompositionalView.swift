//
//  AppsCompositionalView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 14/12/22.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, _ in
            
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)

                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .absolute(260))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: kind, alignment: .topLeading)
                ]
                
                return section
            }
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    static func topSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16
        return section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let dataSource = AppsHomeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        initialFetch()
    }
    
    private func initialSetup() {
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(cell: AppsHeaderCollectionCell.self)
        collectionView.register(cell: AppHorizontalRowCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: CompositionalHeaderView.self)
    }
    
    private func initialFetch() {
        self.activityIndicator.startAnimating()
        self.dataSource.fetchData() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1 + dataSource.sectionGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return dataSource.socialApps.count
        default: return dataSource.sectionGroups[section - 1].feed.results.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withClass: AppsHeaderCollectionCell.self, for: indexPath)
            cell.configure(with: dataSource.socialApps[indexPath.item])
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withClass: AppHorizontalRowCell.self, for: indexPath)
           cell.configure(with: dataSource.sectionGroups[indexPath.section - 1].feed.results[indexPath.item])
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: CompositionalHeaderView.self, for: indexPath)
        let title = dataSource.sectionGroups[indexPath.section - 1].feed.title
        headerView.sectionTitleLabel.text = title
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var appId: String = ""
        
        if indexPath.section == 0 {
            appId = dataSource.socialApps[indexPath.item].id
        } else {
            appId = dataSource.sectionGroups[indexPath.section - 1].feed.results[indexPath.item].id
        }
        
        let controller = AppDetailController(appId: appId)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

struct AppsView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .ignoresSafeArea(.all)
    }
}
