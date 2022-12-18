//
//  AppInfoFloatingView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import UIKit

class AppInfoFloatingView: UIView {
    
    private let downloadButton = DownloadButton(type: .system)
    private let appIconImageView = UIImageView(cornerRadius: 10)
    private let nameLabel = UILabel(text: "", font: .bold(18))
    private let categoryLabel = UILabel(text: "", font: .regular(15), textColor: .secondaryLabel)
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
      //  backgroundColor = .red
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addSubview(blurEffectView)
        
        blurEffectView.fillSuperviewConstraints()
        blurEffectView.layer.cornerRadius = 16
        blurEffectView.clipsToBounds = true
        
        appIconImageView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        
        let labelsStackView = VerticalStack(arrangedSubviews: [nameLabel, categoryLabel], spacing: 2)
        
        let basicInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, downloadButton])
        basicInfoStackView.spacing = 12
        basicInfoStackView.axis = .horizontal
        basicInfoStackView.alignment = .center
        
        addSubviews(basicInfoStackView)
        
        basicInfoStackView.fillSuperviewConstraints(.init(top: 0, left: 12, bottom: 0, right: 12))
        appIconImageView.equalSizeConstraints(58)
        downloadButton.sizeConstraints(width: 74, height: 32)
    }
    
    func configure(with item: TodayItem?) {
        guard let item = item else { return }
        nameLabel.text = item.category
        categoryLabel.text = item.title
        appIconImageView.image = UIImage(named: item.imageName ?? "")
    }
}
