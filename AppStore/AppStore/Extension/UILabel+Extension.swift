//
//  UILabel+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, textColor: UIColor = .label, alignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
    }
}
