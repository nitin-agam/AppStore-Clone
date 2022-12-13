//
//  SearchHomeController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class SearchHomeController: BaseCollectionListController {
    
    private let enterSearchTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = .tertiaryLabel
        label.text = "Enter search text above..."
        label.textAlignment = .center
        return label
    }()
    
    private var searchDelayTimer: Timer?
    private let dataSource = SearchHomeDataSource()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        collectionView.register(cell: SearchCollectionCell.self)
        collectionView.alwaysBounceVertical = true
        
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Games, Apps, Stories and More"
        
        collectionView.addSubview(enterSearchTextLabel)
        enterSearchTextLabel.centerXInSuperviewConstraints()
        enterSearchTextLabel.makeConstraints(top: collectionView.topAnchor, padding: .init(top: 100, left: 0, bottom: 0, right: 0))
    }
}

// MARK: UICollectionViewDataSource
extension SearchHomeController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rows = dataSource.numberOfRows(in: section)
        enterSearchTextLabel.isHidden = rows != 0
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: SearchCollectionCell.self, for: indexPath)
        cell.configure(with: dataSource.object(at: indexPath))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let feed = dataSource.object(at: indexPath), let trackId = feed.trackId else {
            return
        }
        
        let controller = AppDetailController(appId: String(trackId))
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchHomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelayTimer?.invalidate()
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                                repeats: false,
                                                block: { [weak self] _ in
            guard let self = self else { return }
            self.dataSource.fetchRequest(searchText: searchText) { isSuccess in
                if isSuccess {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        })
    }
}
