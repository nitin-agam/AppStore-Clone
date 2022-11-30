//
//  TodayFeedCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class TodayFeedCell: BaseCollectionCell {
    
    private let imageView = UIImageView(cornerRadius: 0, mode: .scaleAspectFit)
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageView.image = UIImage(named: "garden")
        addSubviews(imageView)
        imageView.centerInSuperviewConstraints(.init(width: 200, height: 200))
    }
}
