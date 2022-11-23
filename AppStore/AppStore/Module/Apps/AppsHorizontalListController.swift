//
//  AppsHorizontalListController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 20/11/22.
//

import UIKit

class AppsHorizontalListController: BaseHorizontalListController {

    private let topBottomPadding: CGFloat = 8
    private let lineSpacing: CGFloat = 10
    var feedResults: [FeedResult]?
    var didTapFeed: ((FeedResult?) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        collectionView.register(cell: AppHorizontalRowCell.self)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: UICollectionViewDataSource
extension AppsHorizontalListController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feedResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing + 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: collectionView.frame.width - 48, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: AppHorizontalRowCell.self, for: indexPath)
        cell.configure(with: feedResults?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapFeed?(feedResults?[indexPath.row])
    }
}
