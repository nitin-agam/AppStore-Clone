//
//  AppScreenshotPreviewCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 24/11/22.
//

import UIKit

class AppScreenshotsPreviewCell: BaseCollectionCell {
    
    private let sectionTitleLabel = UILabel(text: "Preview", font: .bold(24))
    let controller = AppScreenshotsPreviewController()
    
    
    override func initialSetup() {
        super.initialSetup()
        
        addSubviews(sectionTitleLabel, controller.view)
        
        sectionTitleLabel.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        controller.view.makeConstraints(top: sectionTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    func configure(urlStrings: [String]?) {
        guard let stringArray = urlStrings else { return }
        controller.screenshotURLs = stringArray
        controller.collectionView.reloadData()
    }
}
