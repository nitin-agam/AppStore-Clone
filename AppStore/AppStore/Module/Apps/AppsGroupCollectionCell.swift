//
//  AppsGroupCollectionCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppsGroupCollectionCell: BaseCollectionCell {
    
    private let sectionTitleLabel = UILabel(text: "App Section", font: .bold(24))
    
    private let controller = AppsHorizontalListController()
    
    
    override func initialSetup() {
        super.initialSetup()
        
        addSubviews(sectionTitleLabel, controller.view)
        
        sectionTitleLabel.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        controller.view.makeConstraints(top: sectionTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
