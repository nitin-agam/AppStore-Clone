//
//  TodayAppGroupCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

class TodayAppGroupCell: TodayAppBaseCell {
    
    private let categoryLabel = UILabel(text: "", font: .medium(17), textColor: .systemGray)
    private let titleLabel = UILabel(text: "", font: .bold(25))
    var topConstraint: NSLayoutConstraint?
    private let controller = TodayAppGroupController(mode: .small)
    private var item: TodayItem?
    var appSelectionHandler: ((_ appId: String) -> ())?
    
    
    override func initialUISetup() {
        super.initialUISetup()
        
        let stackView = VerticalStack(arrangedSubviews: [categoryLabel, titleLabel, controller.view], spacing: 12)
        addSubview(stackView)
        
        stackView.makeConstraints(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true
        
        let backColor = UIColor.secondarySystemBackground
        
        backgroundColor = backColor
        controller.view.backgroundColor = backColor
        controller.collectionView.backgroundColor = backColor
    }
    
    func configure(with item: TodayItem?) {
        self.item = item
        guard let item = item else { return }
        categoryLabel.text = item.category
        titleLabel.text = item.title
        controller.apps = item.result
        controller.collectionView.reloadData()
        
        controller.appSelectionHandler = { appId in
            self.appSelectionHandler?(appId)
        }
        
        controller.view.backgroundColor = .clear
        controller.collectionView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUp()
    }
    
    private func cleanUp() {
        self.item = nil
        categoryLabel.text = nil
        titleLabel.text = nil
        controller.apps = nil
    }
}
