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
        
    //    backgroundColor = .red
        
        addSubviews(controller.view)
        
        controller.view.fillSuperviewConstraints()
        
      //  controller.view.backgroundColor = .purple
      //  controller.collectionView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
