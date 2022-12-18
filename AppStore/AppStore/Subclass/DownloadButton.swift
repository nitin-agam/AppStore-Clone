//
//  DownloadButton.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/12/22.
//

import UIKit

class DownloadButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("GET", for: .normal)
        backgroundColor = UIColor(white: 0.5, alpha: 0.15)
        titleLabel?.font = UIFont.medium(16)
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
