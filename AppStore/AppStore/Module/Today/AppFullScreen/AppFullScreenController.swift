//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class AppFullScreenController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cell: AppFullScreenDescriptionCell.self)
        tableView.register(cell: AppFullScreenHeaderCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    lazy var closeButton: UIButton = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large))
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleCloseTapped), for: .touchUpInside)
        return button
    }()
    
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        view.addSubviews(tableView, closeButton)
        
        tableView.fillSuperviewConstraints()
        
        #warning("update this code as it's will be deprecated soon.")
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene
        let statusBarHeight = window?.statusBarManager?.statusBarFrame.height ?? 0
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
        
        closeButton.makeConstraints(top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 4), size: .init(width: 50, height: 50))
    }
    
    @objc private func handleCloseTapped() {
        closeButton.isHidden = true
        dismissHandler?()
    }
}

extension AppFullScreenController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
          return 450
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withClass: AppFullScreenHeaderCell.self, for: indexPath)
            cell.configure(with: self.todayItem)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withClass: AppFullScreenDescriptionCell.self, for: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
}
