//
//  MusicHomeController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import UIKit

class MusicHomeController: BaseCollectionListController {
    
    private let dataSource = MusicHomeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    private func initialSetup() {
        collectionView.register(cell: MusicRowCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withClass: MusicListLoadingView.self)
        collectionView.alwaysBounceVertical = true
    }
    
    private func fetchData() {
        dataSource.initialFetch(searchText: "arijit") { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.dataSource.isPaginating = false
                }
            }
        }
    }
}

extension MusicHomeController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MusicRowCell.self, for: indexPath)
        cell.configure(with: dataSource.object(at: indexPath))
        
        if dataSource.hasMoreFeed {
            if dataSource.isPaginating == false && indexPath.item == dataSource.numberOfRows(in: indexPath.section) - 1 {
                self.dataSource.isPaginating = true
                fetchData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = dataSource.hasMoreFeed ? 80 : 0
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: MusicListLoadingView.self, for: indexPath)
        return footerView
    }
}
