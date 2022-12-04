//
//  TodayAppGroupCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

class TodayAppGroupCell: BaseCollectionCell {
    
    private let categoryLabel = UILabel(text: "", font: .bold(20))
    private let titleLabel = UILabel(text: "", font: .bold(25))
    var topConstraint: NSLayoutConstraint?
    private let controller = TodayAppGroupController()
    
    
    override func initialSetup() {
        super.initialSetup()
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStack(arrangedSubviews: [categoryLabel, titleLabel, controller.view], spacing: 8)
        addSubview(stackView)
        
        stackView.makeConstraints(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true
    }
    
    func configure(with item: TodayItem?) {
        guard let item = item else { return }
        categoryLabel.text = item.category
        titleLabel.text = item.title
        controller.apps = item.result
        controller.collectionView.reloadData()
        backgroundColor = item.backgroundColor
    }
}

