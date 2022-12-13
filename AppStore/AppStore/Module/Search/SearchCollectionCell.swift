//
//  SearchCollectionView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit
import SDWebImage

class SearchCollectionCell: BaseCollectionCell {
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = .label
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.textColor = .tertiaryLabel
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
        imageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return imageView
    }()
    
    private let screenshotImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return imageView
    }()
    
    private let screenshotImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return imageView
    }()
    
    override func initialSetup() {
        super.initialSetup()
        
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
        
        addSubviews(contentStackView)
        
        contentStackView.fillSuperviewConstraints(.init(top: 16, left: 16, bottom: 16, right: 16))
        appIconImageView.equalSizeConstraints(58)
        downloadButton.sizeConstraints(width: 74, height: 32)
    }
    
    func configure(with appData: AppData?) {
        guard let appObject = appData else { return }
        
        nameLabel.text = appObject.trackName
        categoryLabel.text = appObject.primaryGenreName
        ratingLabel.text = "Ratings: \(appObject.averageUserRating)"
        
        if let appIconUrl = URL(string: appObject.artworkUrl100) {
            appIconImageView.sd_setImage(with: appIconUrl)
        } else {
            appIconImageView.image = nil
        }
        
        guard let screenshotUrls = appObject.screenshotUrls else { return }
        
        if screenshotUrls.count > 0 {
            if let screenshotUrl = URL(string: screenshotUrls[0]) {
                screenshotImageView1.sd_setImage(with: screenshotUrl)
            } else {
                screenshotImageView1.image = nil
            }
            
            if screenshotUrls.count > 1 {
                if let screenshotUrl = URL(string: screenshotUrls[1]) {
                    screenshotImageView2.sd_setImage(with: screenshotUrl)
                } else {
                    screenshotImageView2.image = nil
                }
                
                if screenshotUrls.count > 2 {
                    if let screenshotUrl = URL(string: screenshotUrls[2]) {
                        screenshotImageView3.sd_setImage(with: screenshotUrl)
                    } else {
                        screenshotImageView3.image = nil
                    }
                }
            }
        }
    }
}
