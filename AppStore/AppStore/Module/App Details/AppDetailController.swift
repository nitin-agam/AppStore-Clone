//
//  AppDetailController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 22/11/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppDetailController: BaseCollectionListController {

    private let dataSource = AppDetailDataSource()
    var appId: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        collectionView.register(cell: AppDetailsInfoCell.self)
        collectionView.register(cell: AppScreenshotsPreviewCell.self)
        collectionView.alwaysBounceVertical = true
        navigationItem.largeTitleDisplayMode = .never
        
        dataSource.fetchRequest(appId: self.appId ?? "") {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


// MARK: UICollectionViewDataSource
extension AppDetailController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withClass: AppDetailsInfoCell.self, for: indexPath)
            cell.configure(with: dataSource.object())
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withClass: AppScreenshotsPreviewCell.self, for: indexPath)
        cell.configure(urlStrings: dataSource.object()?.screenshotUrls)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            // calculating the necessary size for our cell somehow
            let dummyInfoCell = AppDetailsInfoCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
            dummyInfoCell.configure(with: dataSource.object())
            dummyInfoCell.layoutIfNeeded()
            
            let estimatedSize = dummyInfoCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            return .init(width: collectionView.frame.width, height: estimatedSize.height)
        }
        
        return .init(width: collectionView.frame.width, height: 500)
    }
}
