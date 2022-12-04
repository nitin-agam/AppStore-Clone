//
//  TodayAppGroupController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 04/12/22.
//

import UIKit

class TodayAppGroupController: BaseCollectionListController {
    
    enum DisplayMode {
        case small
        case full
    }
    
    var mode: DisplayMode
    var apps: [FeedResult]?
    private let cellSpacing: CGFloat = 16
    
    private lazy var closeButton: UIButton = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large))
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    init(mode: DisplayMode) {
        self.mode = mode
        super.init()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        collectionView.register(cell: TodayAppGroupRowCell.self)
        
        if mode == .full {
            view.addSubview(closeButton)
            closeButton.makeConstraints(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 10), size: .init(width: 50, height: 50))
        }
    }
    
    @objc private func handleDismiss() {
        dismiss(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension TodayAppGroupController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mode == .full ? (apps?.count ?? 0) : min(4, apps?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - (mode == .small ? 0 : 40)
        return .init(width: width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        mode == .small ? .zero : .init(top: 12, left: 20, bottom: 12, right: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TodayAppGroupRowCell.self, for: indexPath)
        cell.configure(with: apps?[indexPath.row])
        return cell
    }
}
