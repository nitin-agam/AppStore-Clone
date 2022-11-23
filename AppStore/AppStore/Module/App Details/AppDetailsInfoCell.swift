//
//  AppDetailsInfoCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 23/11/22.
//

import UIKit

class AppDetailsInfoCell: BaseCollectionCell {
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.link
        button.titleLabel?.font = UIFont.semibold(16)
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let appIconImageView = UIImageView(cornerRadius: 20, mode: .scaleAspectFit)
    private let nameLabel = UILabel(text: "", font: .bold(18), lines: 2)
    private let artistNameLabel = UILabel(text: "", font: .regular(14), textColor: .secondaryLabel)
    private let whatsNewLabel = UILabel(text: "What's New", font: .bold(20))
    private let versionLabel = UILabel(text: "", font: .regular(16), textColor: .secondaryLabel)
    private let descriptionLabel = UILabel(text: "", font: .regular(15), lines: 0)
    
    override func initialSetup() {
        super.initialSetup()
        
        appIconImageView.equalSizeConstraints(100)
        downloadButton.sizeConstraints(width: 100, height: 32)
        
        appIconImageView.layer.borderWidth = 0.6
        appIconImageView.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        
        let labelsStackView = VerticalStack(arrangedSubviews: [nameLabel, artistNameLabel, UIView(), downloadButton], spacing: 4)
        
        let basicInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView])
        basicInfoStackView.spacing = 12
        basicInfoStackView.axis = .horizontal
        basicInfoStackView.alignment = .center
        
        let contentStack = VerticalStack(arrangedSubviews: [basicInfoStackView, whatsNewLabel, versionLabel, descriptionLabel], spacing: 12)
        
        addSubviews(contentStack)
        
        contentStack.fillSuperviewConstraints(.init(top: 20, left: 16, bottom: 20, right: 16))
    }
    
    func configure(with appData: AppData?) {
        guard let app = appData else { return }
        
        nameLabel.text = app.trackName
        artistNameLabel.text = app.artistName
        downloadButton.setTitle(app.formattedPrice, for: .normal)
        versionLabel.text = "Version \(app.version)"
        descriptionLabel.text = app.releaseNotes
        
        if let appIconUrl = URL(string: app.artworkUrl100) {
            appIconImageView.sd_setImage(with: appIconUrl)
        } else {
            appIconImageView.image = nil
        }
    }
}
