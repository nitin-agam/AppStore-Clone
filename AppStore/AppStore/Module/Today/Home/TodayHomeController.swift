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
        indicator.tintColor = .systemGray
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    private let dataSource = TodayFeedsDataSource()
    private var startingFrame: CGRect?
    private var appFullScreenController: AppFullScreenController!
    private var anchoredConstraints: AnchoredConstraints?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func initialSetup() {
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerInSuperviewConstraints()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.register(cell: TodayAppCell.self)
        collectionView.register(cell: TodayAppGroupCell.self)
        collectionView.backgroundColor = UIColor.systemGray6
        
        dataSource.fetchData {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension TodayHomeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 40, height: 450)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource.items[indexPath.item]
        
        switch item.itemType {
        case .single:
            let cell = collectionView.dequeueReusableCell(withClass: TodayAppCell.self, for: indexPath)
            cell.configure(with: item)
            return cell
            
        case .multiple:
            let cell = collectionView.dequeueReusableCell(withClass: TodayAppGroupCell.self, for: indexPath)
            cell.configure(with: item)
            
            cell.appSelectionHandler = { [weak self] appId in
                guard let self = self else { return }
                let detailsController = AppDetailController(appId: appId)
                self.navigationController?.pushViewController(detailsController, animated: true)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.items[indexPath.item]
        switch item.itemType {
        case .multiple: presentAppGroupController(item)
        case .single: presentSingleAppController(indexPath, item: item)
        }
    }
    
    private func presentAppGroupController(_ item: TodayItem) {
        let appGroupController = TodayAppGroupController(mode: .full)
        appGroupController.apps = item.result
        let navigation = UINavigationController(rootViewController: appGroupController)
        present(navigation, animated: true)
    }
    
    private func presentSingleAppController(_ indexPath: IndexPath, item: TodayItem) {
        
        // setup controller
        setupFullScreenController(item)
        
        // setup starting position
        setupFullScreenStartingPosition(indexPath)
        
        // begin animation
        beginFullScreenAnimation()
    }
    
    private func setupFullScreenController(_ item: TodayItem) {
        let fullScreenController = AppFullScreenController()
        appFullScreenController = fullScreenController
        appFullScreenController.todayItem = item
        appFullScreenController.view.layer.cornerRadius = 16
        appFullScreenController.dismissHandler = {
            self.endFullScreenAnimation()
        }
    }
    
    private func setupStartingFrame(_ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TodayAppCell else {
            return
        }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {
            return
        }
        
        self.startingFrame = startingFrame
    }
    
    private func setupFullScreenStartingPosition(_ indexPath: IndexPath) {
        
        setupStartingFrame(indexPath)
        
        let fullScreenView = appFullScreenController.view!
        view.addSubview(fullScreenView)
        
        addChild(appFullScreenController)
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let startingFrame = startingFrame else { return }
        
        self.anchoredConstraints = fullScreenView.makeConstraints(top: view.topAnchor,
                                                                 leading: view.leadingAnchor,
                                                                 bottom: nil,
                                                                 trailing: nil,
                                                                 padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0),
                                                                 size: .init(width: startingFrame.width, height: startingFrame.height))
        self.view.layoutIfNeeded()
    }
    
    private func beginFullScreenAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            guard let cell = self.appFullScreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCollectionCell.topConstraint?.constant = 48
            cell.layoutIfNeeded()
        }
    }
    
    private func endFullScreenAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            guard let frame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = frame.origin.y
            self.anchoredConstraints?.leading?.constant = frame.origin.x
            self.anchoredConstraints?.width?.constant = frame.width
            self.anchoredConstraints?.height?.constant = frame.height
            
            self.view.layoutIfNeeded()
            
            self.appFullScreenController?.tableView.contentOffset = .zero
            
            guard let cell = self.appFullScreenController?.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCollectionCell.topConstraint?.constant = 24
            cell.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
        } completion: { _ in
            self.appFullScreenController?.view?.removeFromSuperview()
            self.appFullScreenController?.removeFromParent()
        }
    }
}
