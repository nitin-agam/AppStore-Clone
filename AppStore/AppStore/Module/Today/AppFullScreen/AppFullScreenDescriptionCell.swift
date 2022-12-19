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
        
        
        let attributedText = NSMutableAttributedString(string: "Vitamins & Minerals", attributes: [.foregroundColor: UIColor.label])
        
        attributedText.append(NSAttributedString(string: " are essential micronutrients our bodies require in order to stay healthy. The CareClinic app can keep track of your vitamin and mineral intake, improving your diet-related decisions. You will see whether there are any nutritional deficiencies and, thus, be able to concentrate on eating more nutrient-rich foods.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nVegetarians", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nIf you have decided to follow a specific diet, such as a vegetarian one. You can benefit from tracking your daily intake of vitamins, minerals and other nutrients. In this way, you can make sure that you are getting enough of each nutrient, avoiding nutritional gaps.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nLosing weight & staying healthy", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nIf you have decided to lose weight, a good way to do that is to reduce your overall intake of calories. However, a calorie-reduced diet can present a number of health risks, especially with regard to vitamin and mineral deficiencies. In order to stay healthy, you must keep track of your nutrient intake and the foods consumed in your diet.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nVegetarians", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nIf you have decided to follow a specific diet, such as a vegetarian one. You can benefit from tracking your daily intake of vitamins, minerals and other nutrients. In this way, you can make sure that you are getting enough of each nutrient, avoiding nutritional gaps.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nLosing weight & staying healthy", attributes: [.foregroundColor: UIColor.label]))
        
        attributedText.append(NSAttributedString(string: "\nIf you have decided to lose weight, a good way to do that is to reduce your overall intake of calories. However, a calorie-reduced diet can present a number of health risks, especially with regard to vitamin and mineral deficiencies. In order to stay healthy, you must keep track of your nutrient intake and the foods consumed in your diet.", attributes: [.foregroundColor: UIColor.systemGray]))
        
        
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
