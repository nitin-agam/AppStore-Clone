//
//  MusicHomeController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 13/12/22.
//

import UIKit

class MusicHomeController: BaseCollectionListController {
    
    private let enterSearchTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = .tertiaryLabel
        label.text = "Enter search text above..."
        label.textAlignment = .center
        return label
    }()
    
    private let dataSource = MusicHomeDataSource()
    private var searchDelayTimer: Timer?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withClass: MusicListLoadingView.self)
        collectionView.register(cell: MusicRowCell.self)
        collectionView.alwaysBounceVertical = true
        
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Music"
        
        collectionView.addSubview(enterSearchTextLabel)
        enterSearchTextLabel.centerXInSuperviewConstraints()
        enterSearchTextLabel.makeConstraints(top: collectionView.topAnchor, padding: .init(top: 100, left: 0, bottom: 0, right: 0))
    }
    
    private func fetchData() {
        dataSource.search(searchText: self.searchText, newSearch: false) { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.dataSource.isPaginating = false
                }
            }
        }
    }
}

extension MusicHomeController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rows = dataSource.numberOfRows(in: section)
        enterSearchTextLabel.isHidden = rows != 0
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: MusicRowCell.self, for: indexPath)
        cell.configure(with: dataSource.object(at: indexPath))
        
        if dataSource.hasMoreFeed {
            if dataSource.isPaginating == false && indexPath.item == dataSource.numberOfRows(in: indexPath.section) - 1 {
                self.dataSource.isPaginating = true
                fetchData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = dataSource.hasMoreFeed ? 80 : 0
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: MusicListLoadingView.self, for: indexPath)
        return footerView
    }
}

extension MusicHomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        searchDelayTimer?.invalidate()
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                                repeats: false,
                                                block: { [weak self] _ in
            guard let self = self else { return }
            self.dataSource.search(searchText: searchText, newSearch: true) { isSuccess in
                if isSuccess {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        })
    }
}
