//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 30/11/22.
//

import UIKit

class AppFullScreenController: UITableViewController {

    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(cell: AppFullScreenDescriptionCell.self)
        tableView.register(cell: AppFullScreenHeaderCell.self)
        tableView.showsVerticalScrollIndicator = false
    }
    
    @objc private func handleCloseTapped(_ button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
}

extension AppFullScreenController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
          return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withClass: AppFullScreenHeaderCell.self, for: indexPath)
            cell.closeButton.addTarget(self, action: #selector(handleCloseTapped), for: .touchUpInside)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withClass: AppFullScreenDescriptionCell.self, for: indexPath)
        return cell
    }
}
