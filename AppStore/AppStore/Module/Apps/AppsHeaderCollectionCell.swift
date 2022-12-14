//
//  AppsHeaderCollectionCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppsHeaderCollectionCell: BaseCollectionCell {
    
    private let titleLabel = UILabel(text: "title label", font: .regular(13), textColor: .blue)
    private let subtitleLabel = UILabel(text: "subtitle label", font: .regular(20))
    
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
    
    func configure(with socialApp: SocialApp?) {
        
        guard let socialApp = socialApp else { return }
        
        titleLabel.text = socialApp.name
        subtitleLabel.text = socialApp.tagline
        
        if let appIconUrl = URL(string: socialApp.imageUrl) {
            contentImageView.sd_setImage(with: appIconUrl)
        } else {
            contentImageView.image = nil
        }
    }
}
