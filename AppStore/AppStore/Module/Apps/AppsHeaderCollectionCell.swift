//
//  AppsHeaderCollectionCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppsHeaderCollectionCell: BaseCollectionCell {
    
    private let titleLabel = UILabel(text: "Instagram", font: .regular(13), textColor: .blue)
    private let subtitleLabel = UILabel(text: "This application is based on social media and quite popular app.", font: .regular(20))
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        subtitleLabel.numberOfLines = 2
        
        let stackView = VerticalStack(arrangedSubviews: [titleLabel, subtitleLabel, contentImageView], spacing: 10)
        
        addSubview(stackView)
        
        stackView.fillSuperviewConstraints(.init(top: 16, left: 0, bottom: 0, right: 0))
    }
}
