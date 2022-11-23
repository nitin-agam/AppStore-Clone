//
//  AppsHomeController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class AppsHomeController: BaseCollectionListController {
    
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
        collectionView.register(cell: AppsGroupCollectionCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: AppsCollectionHeaderView.self)
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperviewConstraints()
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
}

// MARK: UICollectionViewDataSource
extension AppsHomeController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let hasHeaderData = dataSource.socialApps.count > 0
        return .init(width: collectionView.frame.width, height: hasHeaderData ? 300 : 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: AppsCollectionHeaderView.self, for: indexPath)
        headerView.configure(with: dataSource.socialApps)
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AppsGroupCollectionCell.self, for: indexPath)
        cell.configure(appGroup: dataSource.object(at: indexPath))
        
        cell.controller.didTapFeed = { [weak self] feedResult in
            guard let self = self, let feed = feedResult else { return }
            let controller = AppDetailController()
            controller.appId = feed.id
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
