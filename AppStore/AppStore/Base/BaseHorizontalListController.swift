//
//  BaseHorizontalListController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 22/11/22.
//

import UIKit

class BaseHorizontalListController: UICollectionViewController {

    init() {
        let layout = SnappingCollectionLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}
