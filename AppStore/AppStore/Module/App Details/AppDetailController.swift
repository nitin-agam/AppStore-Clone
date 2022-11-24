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
        collectionView.register(cell: AppReviewsCell.self)
        collectionView.alwaysBounceVertical = true
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 32, right: 0)
        
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
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withClass: AppScreenshotsPreviewCell.self, for: indexPath)
            cell.configure(urlStrings: dataSource.object()?.screenshotUrls)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: AppReviewsCell.self, for: indexPath)
            cell.configure(reviews: dataSource.reviews)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0.0
        
        if indexPath.item == 0 {
            // calculating the necessary size for our cell somehow
            let dummyInfoCell = AppDetailsInfoCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
            dummyInfoCell.configure(with: dataSource.object())
            dummyInfoCell.layoutIfNeeded()
            
            height = dummyInfoCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000)).height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 250
        }
        
        return .init(width: collectionView.frame.width, height: height)
    }
}
