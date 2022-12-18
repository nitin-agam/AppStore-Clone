//
//  AppFullScreenDescriptionCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class AppFullScreenDescriptionCell: BaseTableCell {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.label])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 8
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedText.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        
        label.font = UIFont.regular(18)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    override func initialSetup() {
        super.initialSetup()
        contentView.addSubview(descriptionLabel)
        descriptionLabel.fillSuperviewConstraints(.init(top: 20, left: 20, bottom: 20, right: 20))
    }
}
