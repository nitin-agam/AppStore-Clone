//
//  AppReviewCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 24/11/22.
//

import UIKit

class AppReviewCell: BaseCollectionCell {
    
    private let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
            imageView.tintColor = .systemYellow
            imageView.sizeConstraints(width: 20, height: 20)
            arrangedSubviews.append(imageView)
        })
        
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    private let titleLabel = UILabel(text: "Review title", font: .semibold(18))
    private let authorLabel = UILabel(text: "Author name", font: .regular(16), textColor: .secondaryLabel, alignment: .right)
    private let starsLabel = UILabel(text: "Ratings", font: .regular(14))
    private let bodyLabel = UILabel(text: "Review body", font: .regular(16), lines: 5)
    
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let topRowStack = UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8)
        let stackView = VerticalStack(arrangedSubviews: [topRowStack, starsStackView, bodyLabel], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        addSubview(stackView)
        stackView.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    func configure(reviewEntry: Entry?) {
        guard let entry = reviewEntry else { return }
        
        titleLabel.text = entry.title.label
        authorLabel.text = entry.author.name.label
        bodyLabel.text = entry.content.label
        
        for (index, view) in starsStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(entry.rating.label) {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
        
        bodyLabel.addVerticalSpacing(3)
    }
}

