//
//  TodayAppCell.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

class TodayAppCell: TodayAppBaseCell {
    
    private let categoryLabel = UILabel(text: "", font: .medium(17), textColor: .systemGray)
    private let titleLabel = UILabel(text: "", font: .bold(25), textColor: .white)
    private let imageView = UIImageView(cornerRadius: 0, mode: .scaleAspectFill)
    private let descriptionLabel = UILabel(text: "", font: .medium(16), textColor: .white, lines: 2)
    var topConstraint: NSLayoutConstraint?
    let imageContainerView = UIView()
    
    
    override func initialUISetup() {
        super.initialUISetup()
        
        imageContainerView.backgroundColor = .clear
        imageContainerView.clipsToBounds = true
        imageContainerView.layer.cornerRadius = 16
        imageContainerView.addSubview(imageView)
        imageView.fillSuperviewConstraints()
        
        addSubview(imageContainerView)
        imageContainerView.fillSuperviewConstraints()
        
        let stackView = VerticalStack(arrangedSubviews: [categoryLabel, titleLabel, UIView(), descriptionLabel], spacing: 12)
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
        backgroundColor = .tertiarySystemBackground
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
