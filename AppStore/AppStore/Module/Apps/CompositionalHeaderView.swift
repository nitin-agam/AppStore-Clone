//
//  CompositionalHeaderView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 14/12/22.
//

import UIKit

class CompositionalHeaderView: UICollectionReusableView {
    
    let sectionTitleLabel = UILabel(text: "", font: .bold(24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
        sectionTitleLabel.makeConstraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
