//
//  UIStackView+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 23/11/22.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
