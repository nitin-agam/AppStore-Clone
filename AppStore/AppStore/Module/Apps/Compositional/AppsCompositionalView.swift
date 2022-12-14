//
//  AppsCompositionalView.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 14/12/22.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, _ in
            
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)

                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300))

                let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                return section
            }
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    static func topSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 16
        item.contentInsets.trailing = 16
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 16
        return section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(cell: UICollectionViewCell.self)
        collectionView.register(cell: AppsHeaderCollectionCell.self)
        collectionView.register(cell: AppHorizontalRowCell.self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withClass: AppsHeaderCollectionCell.self, for: indexPath)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withClass: AppHorizontalRowCell.self, for: indexPath)
            return cell
        }
    }
}

struct AppsView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .ignoresSafeArea(.all)
    }
}
