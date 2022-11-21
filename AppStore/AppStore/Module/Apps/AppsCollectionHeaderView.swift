//
//  AppsCollectionHeaderView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppsCollectionHeaderView: UICollectionReusableView {
    
    private let controller = AppsHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(controller.view)
        controller.view.fillSuperviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with apps: [SocialApp]) {
        controller.socialApps = apps
        controller.collectionView.reloadData()
    }
}
