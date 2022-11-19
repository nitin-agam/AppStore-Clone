//
//  SearchHomeController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchHomeController: UICollectionViewController {

    private let dataSource = SearchHomeDataSource()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        initialFetch()
    }
    
    private func initialSetup() {
        collectionView.register(cell: SearchCollectionCell.self)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
    }
    
    private func initialFetch() {
        dataSource.fetchRequest(searchText: "instagram") {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension SearchHomeController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSection()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfRows(in: section)
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
}
