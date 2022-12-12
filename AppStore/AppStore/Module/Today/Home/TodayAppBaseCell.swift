//
//  TodayAppBaseCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 12/12/22.
//

import UIKit

class TodayAppBaseCell: BaseCollectionCell {
    
    override var isHighlighted: Bool {
        didSet {
            
            // adding press down animations
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1) {
                self.transform = transform
            }
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        layer.cornerRadius = 16
        applyShadow()
        initialUISetup()
    }
    
    func initialUISetup() { }
}
