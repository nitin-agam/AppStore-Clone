//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class AppFullScreenHeaderCell: BaseTableCell {
    
    let todayCollectionCell = TodayAppCell()
    
    let closeButton: UIButton = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large))
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        contentView.addSubviews(todayCollectionCell, closeButton)
        todayCollectionCell.fillSuperviewConstraints()
        
        closeButton.makeConstraints(top: topAnchor, trailing: trailingAnchor, padding: .init(top: 28, left: 0, bottom: 0, right: 4), size: .init(width: 60, height: 60))
        
        todayCollectionCell.clipsToBounds = true
    }
    
    func configure(with item: TodayItem?) {
        todayCollectionCell.configure(with: item)
    }
}
