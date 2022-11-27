//
//  AppReviewCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 24/11/22.
//

import UIKit

class AppReviewCell: BaseCollectionCell {
    
    private let ratingLabel = UILabel(text: "", font: .semibold(18))
    private let titleLabel = UILabel(text: "Review title", font: .semibold(18))
    private let authorLabel = UILabel(text: "Author name", font: .regular(16), textColor: .secondaryLabel, alignment: .right)
    private let starsLabel = UILabel(text: "Ratings", font: .regular(14))
    private let bodyLabel = UILabel(text: "Review body", font: .regular(16), lines: 5)
    
    
    override func initialSetup() {
        super.initialSetup()
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        clipsToBounds = true
        ratingLabel.textColor = .systemYellow
        
        let topRowStack = UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8)
        let stackView = VerticalStack(arrangedSubviews: [topRowStack, ratingLabel, bodyLabel], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        addSubview(stackView)
        stackView.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    func configure(reviewEntry: Entry?) {
        guard let entry = reviewEntry else { return }
        
        titleLabel.text = entry.title.label
        authorLabel.text = entry.author.name.label
        bodyLabel.text = entry.content.label
        
        ratingLabel.text = String(repeating: "★", count: Int(entry.rating.label) ?? 0)
        bodyLabel.addVerticalSpacing(3)
    }
}

