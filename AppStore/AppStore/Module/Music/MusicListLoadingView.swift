//
//  MusicListLoadingView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import UIKit

class MusicListLoadingView: UICollectionReusableView {
    
    private let activtyIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .secondaryLabel
        return indicator
    }()
    
    private let loadingMoreLabel = UILabel(text: "Loading more...", font: .medium(15), textColor: .secondaryLabel, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activtyIndicator.startAnimating()
        
        let stackView = VerticalStack(arrangedSubviews: [activtyIndicator, loadingMoreLabel], spacing: 2)
        addSubview(stackView)
        stackView.fillSuperviewConstraints(.init(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
