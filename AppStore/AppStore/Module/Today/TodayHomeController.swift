//
//  TodayController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class TodayHomeController: BaseCollectionListController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let dataSource = TodayFeedsDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.register(cell: TodayFeedCell.self)
        collectionView.backgroundColor = UIColor.systemGray6
        
     //   view.addSubview(activityIndicator)
     //   activityIndicator.fillSuperviewConstraints()
    }
}

// MARK: UICollectionViewDataSource
extension TodayHomeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 40, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TodayFeedCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 20, right: 20)
    }
}
