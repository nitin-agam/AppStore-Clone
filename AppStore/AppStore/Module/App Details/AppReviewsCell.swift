//
//  AppReviewsCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 24/11/22.
//

import UIKit

class AppReviewsCell: BaseCollectionCell {
    
    private let sectionTitleLabel = UILabel(text: "Reviews & Ratings", font: .bold(24))
    let controller = AppReviewListController()
    
    
    override func initialSetup() {
        super.initialSetup()
        
        addSubviews(sectionTitleLabel, controller.view)
        
        sectionTitleLabel.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        controller.view.makeConstraints(top: sectionTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    func configure(reviews: Reviews?) {
        guard let reviewObject = reviews else { return }
        controller.appReviews = reviewObject.feed.entry
        controller.collectionView.reloadData()
    }
}
