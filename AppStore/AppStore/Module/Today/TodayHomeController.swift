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
    private var startingFrame: CGRect?
    private var appFullScreenController: AppFullScreenController?
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.register(cell: TodayFeedCell.self)
        collectionView.backgroundColor = UIColor.systemGray6
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
        .init(width: collectionView.frame.width - 40, height: 450)
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
        
        let fullScreenController = AppFullScreenController()
        let fullScreenView = fullScreenController.view!
        view.addSubview(fullScreenView)
        fullScreenView.layer.cornerRadius = 16
        fullScreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFullScreenControllerTapGesture(_:))))
        
        appFullScreenController = fullScreenController
        self.startingFrame = startingFrame
        addChild(fullScreenController)
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0?.isActive = true })
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
        }
    }
    
    @objc private func handleFullScreenControllerTapGesture(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            guard let frame = self.startingFrame else { return }
            
            self.topConstraint?.constant = frame.origin.y
            self.leadingConstraint?.constant = frame.origin.x
            self.widthConstraint?.constant = frame.width
            self.heightConstraint?.constant = frame.height
            
            self.view.layoutIfNeeded()
            
            self.appFullScreenController?.tableView.contentOffset = .zero
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
        } completion: { _ in
            gesture.view?.removeFromSuperview()
            self.appFullScreenController?.removeFromParent()
        }
    }
}
