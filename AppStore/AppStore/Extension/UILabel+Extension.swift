//
//  UILabel+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, textColor: UIColor = .label, alignment: NSTextAlignment = .left, lines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
    
    func addVerticalSpacing(_ spacing: CGFloat = 6) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attributedString = NSAttributedString(string: text ?? "", attributes: [.paragraphStyle: paragraphStyle])
        attributedText = attributedString
    }
}
