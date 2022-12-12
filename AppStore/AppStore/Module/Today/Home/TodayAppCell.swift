//
//  TodayAppCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

class TodayAppCell: TodayAppBaseCell {
    
    private let categoryLabel = UILabel(text: "", font: .bold(20))
    private let titleLabel = UILabel(text: "", font: .bold(25))
    private let imageView = UIImageView(cornerRadius: 0, mode: .scaleAspectFill)
    private let descriptionLabel = UILabel(text: "", font: .regular(16), lines: 3)
    var topConstraint: NSLayoutConstraint?
    
    
    override func initialUISetup() {
        super.initialUISetup()
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        imageView.centerInSuperviewConstraints(.init(width: 200, height: 200))
        
        let stackView = VerticalStack(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
        
        stackView.makeConstraints(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true
    }
    
    func configure(with item: TodayItem?) {
        guard let item = item else { return }
        categoryLabel.text = item.category
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        imageView.image = UIImage(named: item.imageName ?? "")
        backgroundColor = item.backgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUp()
    }
    
    private func cleanUp() {
        categoryLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        imageView.image = nil
    }
}
