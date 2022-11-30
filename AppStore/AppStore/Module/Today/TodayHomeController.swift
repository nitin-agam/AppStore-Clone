//
//  TodayController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class TodayHomeController: BaseCollectionListController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let dataSource = TodayFeedsDataSource()
    var startingFrame: CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.register(cell: TodayFeedCell.self)
        collectionView.backgroundColor = UIColor.systemGray6
        
        //   view.addSubview(activityIndicator)
        //   activityIndicator.fillSuperviewConstraints()
    }
}

// MARK: UICollectionViewDataSource
extension TodayHomeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 40, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TodayFeedCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TodayFeedCell else {
            return
        }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        redView.frame = startingFrame
        redView.layer.cornerRadius = 16
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRedTapGesture(_:))))
        
        self.startingFrame = startingFrame
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            redView.frame = self.view.frame
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
        }
    }
    
    @objc private func handleRedTapGesture(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            gesture.view?.frame = self.startingFrame ?? .zero
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
        } completion: { _ in
            gesture.view?.removeFromSuperview()
        }
    }
}
