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
        let cell = collectionView.dequeueReusableCell(withClass: AppDetailsInfoCell.self, for: indexPath)
        cell.configure(with: dataSource.object())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // calculating the necessary size for our cell somehow
        let dummyInfoCell = AppDetailsInfoCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyInfoCell.configure(with: dataSource.object())
        dummyInfoCell.layoutIfNeeded()
        
        let estimatedSize = dummyInfoCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}
