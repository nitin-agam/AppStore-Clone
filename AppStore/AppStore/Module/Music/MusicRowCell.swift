//
//  MusicRowCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import UIKit

class MusicRowCell: BaseCollectionCell {
    
    private let iconImageView = UIImageView(cornerRadius: 10)
    private let nameLabel = UILabel(text: "Music Name", font: .bold(18))
    private let categoryLabel = UILabel(text: "Music Category", font: .regular(16), textColor: .black, lines: 2)
    
    override func initialSetup() {
        super.initialSetup()
        
        iconImageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        
        let labelsStackView = VerticalStack(arrangedSubviews: [nameLabel, categoryLabel], spacing: 2)
        
        let basicInfoStackView = UIStackView(arrangedSubviews: [iconImageView, labelsStackView])
        basicInfoStackView.spacing = 12
        basicInfoStackView.axis = .horizontal
        basicInfoStackView.alignment = .center
        
        let separator = UIView()
        separator.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        
        addSubviews(basicInfoStackView, separator)
        
        separator.makeConstraints(top: nil, leading: iconImageView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0.7))
        
        basicInfoStackView.fillSuperviewConstraints(.init(top: 8, left: 16, bottom: 8, right: 16))
        
        iconImageView.equalSizeConstraints(62)
    }
    
    func configure(with appData: AppData?) {
        guard let appObject = appData else { return }
        
        nameLabel.text = appObject.trackName
        
        if let name = appObject.artistName {
            categoryLabel.text = name + " • " + appObject.primaryGenreName
        } else {
            categoryLabel.text = appObject.primaryGenreName
        }
        
        if let appIconUrl = URL(string: appObject.artworkUrl100) {
            iconImageView.sd_setImage(with: appIconUrl)
        } else {
            iconImageView.image = nil
        }
    }
}
