//
//  AppTabBarController.swift
//  AppStore
//
//  Created by Nitin Aggarwal on 18/11/22.
//

import UIKit

class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let musicNavigation = constructNavigationController(controller: MusicHomeController(), title: "Music", imageName: "music.note.list")
        let todayNavigation = constructNavigationController(controller: TodayHomeController(), title: "Today", imageName: "calendar")
        let appsNavigation = constructNavigationController(controller: CompositionalAppsController(), title: "Apps", imageName: "app.badge")
        let searchNavigation = constructNavigationController(controller: SearchHomeController(), title: "Search", imageName: "magnifyingglass")
        
        viewControllers = [musicNavigation, todayNavigation, appsNavigation, searchNavigation]
    }

    private func constructNavigationController(controller: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = true
        controller.navigationItem.title = title
        controller.view.backgroundColor = .white
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = UIImage(systemName: imageName)
        return navigation
    }
}
