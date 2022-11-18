//
//  SearchCollectionView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class SearchCollectionCell: BaseCollectionCell {
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = .label
        label.text = "Instagram"
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = .secondaryLabel
        label.text = "Social Media"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = .tertiaryLabel
        label.text = "90K+ ratings"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.backgroundColor = .quaternaryLabel
        button.titleLabel?.font = UIFont.semibold(16)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let screenshotImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let screenshotImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let screenshotImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = .yellow
        
        let labelsStackView = VerticalStack(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel], spacing: 2)
        
        let basicInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, downloadButton])
        basicInfoStackView.spacing = 12
        basicInfoStackView.axis = .horizontal
        basicInfoStackView.alignment = .center
        
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshotImageView1, screenshotImageView2, screenshotImageView3])
        screenshotsStackView.spacing = 12
        screenshotsStackView.axis = .horizontal
        screenshotsStackView.distribution = .fillEqually
        
        let contentStackView = VerticalStack(arrangedSubviews: [basicInfoStackView, screenshotsStackView], spacing: 16)
        
        contentView.addSubviews(contentStackView)
        
        contentStackView.fillSuperviewConstraints(.init(top: 16, left: 16, bottom: 16, right: 16))
        appIconImageView.equalSizeConstraints(58)
        downloadButton.sizeConstraints(width: 74, height: 32)
    }
}
