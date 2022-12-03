//
//  TodayFeedCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class TodayFeedCell: BaseCollectionCell {
    
    private let categoryLabel = UILabel(text: "LIFE HACK", font: .bold(20))
    private let titleLabel = UILabel(text: "Utilizing your time", font: .bold(25))
    private let imageView = UIImageView(cornerRadius: 0, mode: .scaleAspectFill)
    private let descriptionLabel = UILabel(text: "This is an app to help you to organize your time in a better way beyond you can think. It is an intelligent app to organize your life the right way.", font: .regular(16), lines: 3)
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.centerInSuperviewConstraints(.init(width: 200, height: 200))
        
        let stackView = VerticalStack(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperviewConstraints(.init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    func configure(with item: TodayItem?) {
        
        guard let item = item else { return }
        
        categoryLabel.text = item.category
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        imageView.image = UIImage(named: item.imageName)
        
        backgroundColor = item.backgroundColor
    }
}
