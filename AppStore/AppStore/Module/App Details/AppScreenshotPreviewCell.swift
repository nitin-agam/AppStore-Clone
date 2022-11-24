//
//  AppScreenshotPreviewCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 24/11/22.
//

import UIKit

class AppScreenshotPreviewCell: BaseCollectionCell {
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 0.6
        imageView.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        return imageView
    }()
    
    
    override func initialSetup() {
        super.initialSetup()
        addSubview(contentImageView)
        contentImageView.fillSuperviewConstraints()
    }
    
    func configure(with urlString: String?) {
        if let string = urlString, let imageUrl = URL(string: string) {
            contentImageView.sd_setImage(with: imageUrl)
        } else {
            contentImageView.image = nil
        }
    }
}
