//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class AppFullScreenHeaderCell: BaseTableCell {
    
    let todayCollectionCell = TodayAppCell()
    
    override func initialSetup() {
        super.initialSetup()
        contentView.addSubviews(todayCollectionCell)
        todayCollectionCell.fillSuperviewConstraints()
        todayCollectionCell.clipsToBounds = true
        todayCollectionCell.imageContainerView.layer.cornerRadius = 0
    }
    
    func configure(with item: TodayItem?) {
        todayCollectionCell.configure(with: item)
    }
}
