//
//  UIImageView+Extension.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

extension UIImageView {
    
    convenience init(cornerRadius: CGFloat, mode: ContentMode = .scaleAspectFit) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.contentMode = mode
        self.clipsToBounds = true
    }
}
