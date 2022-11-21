//
//  AppHorizontalRowCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppHorizontalRowCell: BaseCollectionCell {
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.backgroundColor = .quaternaryLabel
        button.titleLabel?.font = UIFont.semibold(16)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let appIconImageView = UIImageView(cornerRadius: 10)
    private let nameLabel = UILabel(text: "", font: .regular(16))
    private let categoryLabel = UILabel(text: "", font: .regular(13), textColor: .secondaryLabel)
    
    override func initialSetup() {
        super.initialSetup()
        
        nameLabel.numberOfLines = 2
        
        appIconImageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        
        let labelsStackView = VerticalStack(arrangedSubviews: [nameLabel, categoryLabel], spacing: 2)
        
        let basicInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, downloadButton])
        basicInfoStackView.spacing = 12
        basicInfoStackView.axis = .horizontal
        basicInfoStackView.alignment = .center
        
        addSubviews(basicInfoStackView)
        
        basicInfoStackView.fillSuperviewConstraints()
        appIconImageView.equalSizeConstraints(58)
        downloadButton.sizeConstraints(width: 74, height: 32)
    }
    
    func configure(with feedResult: FeedResult?) {
        guard let feed = feedResult else { return }
        
        nameLabel.text = feed.name
        categoryLabel.text = feed.artistName
        
        if let appIconUrl = URL(string: feed.artworkUrl100) {
            appIconImageView.sd_setImage(with: appIconUrl)
        } else {
            appIconImageView.image = nil
        }
    }
}
