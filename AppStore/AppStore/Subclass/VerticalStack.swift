//
//  VerticalStack.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class VerticalStack: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({ addArrangedSubview($0) })
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
